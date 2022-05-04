FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:a8870aa60b45495d298df5b65c69b3d7972608da4367bd6e69d6e392ac969dd4

COPY --chown=1001:0 . /home/eduk8s/
RUN mv /home/eduk8s/workshop /opt/workshop

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# TBS
RUN curl -L -o /usr/local/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.4.2/kp-linux-0.4.2 && \
  chmod 755 /usr/local/bin/kp
# Tanzu
RUN curl -o /usr/local/bin/tanzu https://storage.googleapis.com/tanzu-cli/artifacts/core/latest/tanzu-core-linux_amd64 && \
  chmod 755 /usr/local/bin/tanzu
COPY plugins/apps-artifacts /tmp/apps-artifacts
COPY plugins/apps-artifacts /tmp/apps-artifacts/
RUN tanzu plugin install apps --local /tmp/apps-artifacts --version v0.5.1
COPY plugins/acc-artifacts /tmp/acc-artifacts
COPY plugins/acc-artifacts /tmp/acc-artifacts/
RUN tanzu plugin install accelerator --local /tmp/acc-artifacts --version v1.1.1
# Knative
RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.4.0/kn-linux-amd64 && \
    chmod 755 /usr/local/bin/kn

# Utilities
RUN apt-get update && apt-get install -y unzip openjdk-11-jdk

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
#RUN curl -L https://github.com/tohjustin/kube-lineage/releases/download/v0.4.2/kube-lineage_linux_amd64.tar.gz --output /tmp/kube-lineage_linux_amd64.tar.gz && \
#    tar -zxvf /tmp/kube-lineage_linux_amd64.tar.gz -C /tmp && \
#    mv /tmp/kube-lineage /usr/local/bin/kubectl-lineage

# Install Tilt for eduk8s user in local path under homedir
RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | PATH=~/.local/bin:$PATH bash

USER 1001
RUN fix-permissions /home/eduk8s
