#!/bin/bash
set -x
set +e

jq ". + { \"java.server.launchMode\": \"Standard\", \"tanzu.sourceImage\": \"${REGISTRY_HOST}/spring-sensors-source\", \"tanzu.namespace\": \"${SESSION_NAMESPACE}\", \"redhat.telemetry.enabled\": false, \"telemetry.enabled\": false, \"java.jdt.ls.java.home\": \"/opt/java\", \"maven.pomfile.autoUpdateEffectivePOM\": true}" /home/eduk8s/.local/share/code-server/User/settings.json > /tmp/settings.json
mv /tmp/settings.json /home/eduk8s/.local/share/code-server/User/settings.json

if [[ -z ${POLICY_ENGINE} ]]; then
cat <<'EOF' > /opt/eduk8s/sbin/start-code-server
#!/bin/bash

set -x

set -eo pipefail

CODE_SERVER_BIND_ADDRESS=${CODE_SERVER_BIND_ADDRESS:-127.0.0.1}

EDITOR_HOME=${EDITOR_HOME:-/home/eduk8s/spring-sensors}

exec /opt/code-server/bin/code-server \
    --bind-addr "$CODE_SERVER_BIND_ADDRESS:10085" \
    --auth none \
    --disable-telemetry \
    $EDITOR_HOME
EOF
fi