FROM ghcr.io/vmware-tanzu-labs/educates-jdk17-environment:2.6

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# Tanzu CLI things
RUN printf '[tanzu-cli]\n\
name=Tanzu CLI\n\
baseurl=https://storage.googleapis.com/tanzu-cli-os-packages/rpm/tanzu-cli\n\
enabled=1\n\
gpgcheck=1\n\
repo_gpgcheck=1\n\
gpgkey=https://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub'\
>> /etc/yum.repos.d/tanzu-cli.repo && \
yum install -y tanzu-cli && yum clean all

# TBS
RUN curl -L -o /usr/local/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.12.1/kp-linux-amd64-0.12.1 && \
  chmod 755 /usr/local/bin/kp

# Knative
RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.10.1/kn-linux-amd64 && \
    chmod 755 /usr/local/bin/kn

# Requirements for Live Update
COPY extensions/tanzu-vscode-extension-1.3.1.vsix extensions/tanzu-app-accelerator-1.0.4.vsix /tmp
RUN code-server --install-extension vscjava.vscode-java-pack && \
  code-server --install-extension /tmp/tanzu-vscode-extension-1.3.1.vsix && \
  code-server --install-extension /tmp/tanzu-app-accelerator-1.0.4.vsix

RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
RUN echo -n 'export PATH=~/.local/bin:$PATH' >> /etc/profile
RUN chown -R eduk8s:users /home/eduk8s

USER 1001
RUN fix-permissions /home/eduk8s
RUN curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | PATH=~/.local/bin:$PATH bash
RUN tanzu config eula accept && \
 TANZU_CLI_CEIP_OPT_IN_PROMPT_ANSWER=no tanzu plugin install --group vmware-tanzucli/essentials:v1.0.0 && \
 TANZU_CLI_CEIP_OPT_IN_PROMPT_ANSWER=no tanzu plugin install --group vmware-tap/default:v1.7.5

COPY --chown=1001:100 workload.yaml deliverable.yaml /home/eduk8s
COPY --chown=1001:100 workshop/ /opt/workshop
