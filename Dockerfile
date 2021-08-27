FROM quay.io/eduk8s/base-environment:201203.020609.1ab533d
#conftest 
COPY --from=harbor-repo.vmware.com/dockerhub-proxy-cache/instrumenta/conftest /conftest /usr/local/bin/conftest
# All the direct Downloads need to run as root as  they are going to /usr/local/bin
USER root
# TMC
RUN curl -L -o /usr/local/bin/tmc $(curl -s https://tanzupaorg.tmc.cloud.vmware.com/v1alpha/system/binaries | jq -r 'getpath(["versions",.latestVersion]).linuxX64') && \
  chmod 755 /usr/local/bin/tmc
# Policy Tools
RUN curl -L -o /usr/local/bin/opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64 && \
  chmod 755 /usr/local/bin/opa
# Velero
RUN VELERO_DOWNLOAD_URL=$(curl -s https://api.github.com/repos/vmware-tanzu/velero/releases/latest | jq -r '.assets[] | select ( .name | contains("linux-amd64") ) .browser_download_url') && \
  curl -fL --output /tmp/velero.tar.gz ${VELERO_DOWNLOAD_URL} && \
  tar -xzf /tmp/velero.tar.gz -C /usr/local/bin --strip-components=1 --wildcards velero-*-linux-amd64/velero && \
  rm /tmp/velero.tar.gz
# TAC
RUN curl -fL --output /tmp/tac.tar.gz https://downloads.bitnami.com/tac/tac-cli_beta-e936104-linux_amd64.tar.gz && \
  tar -xzf /tmp/tac.tar.gz -C /usr/local/bin tac && \
  rm /tmp/tac.tar.gz
# TBS
RUN curl -L -o /usr/local/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.3.1/kp-linux-0.3.1 && \
  chmod 755 /usr/local/bin/kp
RUN curl -sSL "https://github.com/buildpacks/pack/releases/download/v0.20.0/pack-v0.20.0-linux.tgz" | sudo tar -C /usr/local/bin/ --no-same-owner -xzv pack
#tanzu
RUN curl -o /usr/local/bin/tanzu https://storage.googleapis.com/tanzu-cli/artifacts/core/latest/tanzu-core-linux_amd64 && \
  chmod 755 /usr/local/bin/tanzu

USER 1001