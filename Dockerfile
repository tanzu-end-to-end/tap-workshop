FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:a8870aa60b45495d298df5b65c69b3d7972608da4367bd6e69d6e392ac969dd4

COPY --chown=1001:0 . /home/eduk8s/
RUN mv /home/eduk8s/workshop /opt/workshop

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# TBS
RUN curl -L -o /usr/local/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.5.0/kp-linux-0.5.0 && \
  chmod 755 /usr/local/bin/kp
# Tanzu
COPY /plugins/core/v0.11.2/tanzu-core-linux_amd64 /usr/local/bin/tanzu
RUN chmod 755 /usr/local/bin/tanzu
COPY /plugins/discovery /tmp/discovery
COPY /plugins/distribution /tmp/distribution
RUN tanzu plugin install --local /tmp all

# Knative
RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.4.1/kn-linux-amd64 && \
    chmod 755 /usr/local/bin/kn

# Utilities
RUN apt-get clean && apt-get update && apt-get install -y unzip openjdk-11-jdk

# Requirements for Live Update
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 4.3.0
RUN mv /usr/bin/code-server /opt/code-server/bin/code-server
COPY extensions/tanzu-vscode-extension.vsix /tmp
RUN code-server --install-extension vscjava.vscode-java-pack && \
    code-server --install-extension /tmp/tanzu-vscode-extension.vsix
RUN echo -n 'export PATH=~/.local/bin:$PATH' >> /etc/profile
RUN chown -R eduk8s:users /home/eduk8s/.cache
RUN chown -R eduk8s:users /home/eduk8s/.local
RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
RUN chown -R eduk8s:users /home/eduk8s/.tilt-dev

# Install Tilt for eduk8s user in local path under homedir
RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | PATH=~/.local/bin:$PATH bash

USER 1001
RUN fix-permissions /home/eduk8s
