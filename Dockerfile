FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:39a5afe9604b9a36c14deda351ab73b53d15bd53085d89829838671cb867f6c4

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# Apt things
RUN curl -fsSL https://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub | gpg --dearmor -o /etc/apt/keyrings/tanzu-archive-keyring.gpg && \
  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/tanzu-archive-keyring.gpg] https://storage.googleapis.com/tanzu-cli-os-packages/apt tanzu-cli-jessie main" | sudo tee /etc/apt/sources.list.d/tanzu.list && \
  apt-get clean && apt-get update && apt-get install -y unzip openjdk-17-jdk-headless tanzu-cli
# TBS
RUN curl -L -o /usr/local/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.12.1/kp-linux-amd64-0.12.1 && \
  chmod 755 /usr/local/bin/kp
# Knative
RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.10.1/kn-linux-amd64 && \
    chmod 755 /usr/local/bin/kn

# Requirements for Live Update
COPY extensions/tanzu-vscode-extension-1.0.6.vsix extensions/tanzu-app-accelerator-0.1.6.vsix /tmp
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 4.21.0 && \
  mv /usr/bin/code-server /opt/code-server/bin/code-server && \
  code-server --install-extension vscjava.vscode-java-pack && \
  code-server --install-extension /tmp/tanzu-vscode-extension-1.0.6.vsix && \
  code-server --install-extension /tmp/tanzu-app-accelerator-0.1.6.vsix

RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
RUN echo -n 'export PATH=~/.local/bin:$PATH' >> /etc/profile
RUN chown -R eduk8s:users /home/eduk8s/.cache /home/eduk8s/.tilt-dev /home/eduk8s/.config/tanzu /home/eduk8s/.local/share/tanzu-cli

USER 1001
RUN fix-permissions /home/eduk8s
#RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | PATH=~/.local/bin:$PATH bash
RUN tanzu config eula accept && \
 TANZU_CLI_CEIP_OPT_IN_PROMPT_ANSWER=no tanzu plugin install --group vmware-tanzucli/essentials:v1.0.0 && \
 TANZU_CLI_CEIP_OPT_IN_PROMPT_ANSWER=no tanzu plugin install --group vmware-tap/default:v1.6.7

COPY --chown=1001:100 workload.yaml deliverable.yaml /home/eduk8s
COPY --chown=1001:100 workshop/ /opt/workshop


