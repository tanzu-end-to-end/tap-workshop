FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:a8870aa60b45495d298df5b65c69b3d7972608da4367bd6e69d6e392ac969dd4

COPY --chown=1001:0 . /home/eduk8s/
RUN mv /home/eduk8s/workshop /opt/workshop
RUN fix-permissions /home/eduk8s

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# TMC
RUN curl -L -o /usr/local/bin/tmc $(curl -s https://tanzupaorg.tmc.cloud.vmware.com/v1alpha/system/binaries | jq -r 'getpath(["versions",.latestVersion]).linuxX64') && \
  chmod 755 /usr/local/bin/tmc
# TBS
RUN curl -L -o /usr/local/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.4.2/kp-linux-0.4.2 && \
  chmod 755 /usr/local/bin/kp
# Tanzu
RUN curl -o /usr/local/bin/tanzu https://storage.googleapis.com/tanzu-cli/artifacts/core/latest/tanzu-core-linux_amd64 && \
  chmod 755 /usr/local/bin/tanzu
COPY plugins/apps-artifacts /tmp/apps-artifacts
COPY plugins/apps-artifacts /tmp/apps-artifacts/
RUN tanzu plugin install apps --local /tmp/apps-artifacts --version v0.4.0
COPY plugins/acc-artifacts /tmp/acc-artifacts
COPY plugins/acc-artifacts /tmp/acc-artifacts/
RUN tanzu plugin install accelerator --local /tmp/acc-artifacts --version v1.0.0
# Knative
RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.3.1/kn-linux-amd64 && \
    chmod 755 /usr/local/bin/kn

# Utilities
RUN apt-get update && apt-get install -y unzip openjdk-11-jdk

# Requirements for Live Update
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 4.2.0
RUN mv /usr/bin/code-server /opt/code-server/bin/code-server
RUN code-server --install-extension redhat.vscode-yaml && \
    code-server --install-extension redhat.java && \
    code-server --install-extension vscjava.vscode-java-pack && \
    code-server --install-extension /opt/tanzu-vscode-extension.vsix
COPY extensions/tanzu-vscode-extension.vsix /home/eduk8s/.local/share/code-server/extensions/
COPY extensions/ms-kubernetes-tools.vscode-kubernetes-tools-1.3.7.vsix /home/eduk8s/.local/share/code-server/extensions/
COPY extensions/ms-toolsai.jupyter-2022.3.1000901801.vsix /home/eduk8s/.local/share/code-server/extensions/
COPY extensions/golang.Go-0.32.0.vsix /home/eduk8s/.local/share/code-server/extensions/
COPY extensions/humao.rest-client-0.24.6.vsix /home/eduk8s/.local/share/code-server/extensions/
COPY extensions/ms-python.python-2022.2.1924087327.vsix /home/eduk8s/.local/share/code-server/extensions/
#RUN mv /opt/code-server/extensions/ms-toolsai.jupyter-2021.6.99 /opt/code-server/extensions/ms-kubernetes-tools.vscode-kubernetes-tools-1.2.4 /opt/code-server/extensions/golang.go-0.27.2 /opt/code-server/extensions/humao.rest-client-0.24.3 /opt/code-server/extensions/ms-python.python-2021.8.1159798656 /opt/code-server/extensions/pivotal.eduk8s-vscode-helper-0.0.1 /home/eduk8s/.local/share/code-server/extensions/
RUN echo -n 'export PATH=~/.local/bin:$PATH' >> /etc/profile
RUN chown -R eduk8s:users /home/eduk8s/.cache
RUN chown -R eduk8s:users /home/eduk8s/.local
RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
RUN chown -R eduk8s:users /home/eduk8s/.tilt-dev
RUN curl -L https://github.com/tohjustin/kube-lineage/releases/download/v0.4.2/kube-lineage_linux_amd64.tar.gz --output /tmp/kube-lineage_linux_amd64.tar.gz && \
    tar -zxvf /tmp/kube-lineage_linux_amd64.tar.gz -C /tmp && \
    mv /tmp/kube-lineage /usr/local/bin/kubectl-lineage
RUN apt-get install -y ruby && \
    curl -L -o /tmp/eksporter.tar.gz https://github.com/Kyrremann/kubectl-eksporter/releases/download/v1.7.0/eksporter.tar.gz && \
    tar -zxvf /tmp/eksporter.tar.gz -C /tmp && \
    mv /tmp/eksporter.rb /usr/local/bin/kubectl-eksporter

# Install Tilt for eduk8s user in local path under homedir
RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | PATH=~/.local/bin:$PATH bash

USER 1001