FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:36b8462ffdf064372e6124bf093e075b140ff2978b536477f28025253cb647cd

COPY --chown=1001:0 . /home/eduk8s/
RUN mv /home/eduk8s/workshop /opt/workshop

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# TBS
RUN curl -L -o /usr/local/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.9.0/kp-linux-amd64-0.9.0 && \
  chmod 755 /usr/local/bin/kp
# Tanzu
COPY /plugins/core/v0.25.4/tanzu-core-linux_amd64 /usr/local/bin/tanzu
RUN chmod 755 /usr/local/bin/tanzu
COPY /plugins/discovery /tmp/discovery
COPY /plugins/distribution /tmp/distribution
RUN tanzu plugin install --local /tmp all
RUN chmod -R 755 .config/tanzu
# Knative
RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.8.1/kn-linux-amd64 && \
    chmod 755 /usr/local/bin/kn

# Utilities
RUN apt-get clean && apt-get update && apt-get install -y unzip openjdk-17-jdk

# Requirements for Live Update
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 4.9.1
RUN mv /usr/bin/code-server /opt/code-server/bin/code-server
COPY extensions/tanzu-vscode-extension-0.13.0.vsix /tmp
COPY extensions/tanzu-app-accelerator-0.1.5.vsix /tmp
RUN code-server --install-extension vscjava.vscode-java-pack && \
    code-server --install-extension /tmp/tanzu-vscode-extension-0.13.0.vsix && \
    code-server --install-extension /tmp/tanzu-app-accelerator-0.1.5.vsix
RUN echo -n 'export PATH=~/.local/bin:$PATH' >> /etc/profile
RUN chown -R eduk8s:users /home/eduk8s/.cache
RUN chown -R eduk8s:users /home/eduk8s/.local
RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
RUN chown -R eduk8s:users /home/eduk8s/.tilt-dev

# Install Tilt for eduk8s user in local path under homedir
RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | PATH=~/.local/bin:$PATH bash

USER 1001
RUN fix-permissions /home/eduk8s
