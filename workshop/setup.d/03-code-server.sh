#!/bin/bash
set -x
set +e

jq ". + { \"java.server.launchMode\": \"Standard\", \"tanzu.sourceImage\": \"${REGISTRY_HOST}/spring-sensors-source\", \"tanzu.namespace\": \"${SESSION_NAMESPACE}\", \"tanzu-app-accelerator.tapGuiUrl\": \"https://tap-gui.${VIEW_CLUSTER_DOMAIN}\", \"redhat.telemetry.enabled\": false }" /home/eduk8s/.local/share/code-server/User/settings.json > /tmp/settings.json
mv /tmp/settings.json /home/eduk8s/.local/share/code-server/User/settings.json

# Accelerator code found at /home/eduk8s/.local/share/code-server/extensions/vmware.tanzu-app-accelerator-0.1.5/dist/extension.js
mv src/extension.js /home/eduk8s/.local/share/code-server/extensions/vmware.tanzu-app-accelerator-0.1.5/dist/extension.js

cat <<'EOF' > /opt/eduk8s/sbin/start-code-server
#!/bin/bash

set -x

set -eo pipefail

CODE_SERVER_BIND_ADDRESS=${CODE_SERVER_BIND_ADDRESS:-127.0.0.1}

EDITOR_HOME=${EDITOR_HOME:-/home/eduk8s}

exec /opt/code-server/bin/code-server \
    --bind-addr "$CODE_SERVER_BIND_ADDRESS:10085" \
    --auth none \
    --disable-telemetry \
    $EDITOR_HOME
EOF
