#!/bin/bash
set -x
set +e

cat <<'EOF' > /opt/eduk8s/sbin/start-code-server
#!/bin/bash

set -x

set -eo pipefail

CODE_SERVER_BIND_ADDRESS=${CODE_SERVER_BIND_ADDRESS:-127.0.0.1}

#EDITOR_HOME=${EDITOR_HOME:-/home/eduk8s/spring-sensors}
EDITOR_HOME=/home/eduk8s/spring-sensors

exec /opt/code-server/bin/code-server \
    --bind-addr "$CODE_SERVER_BIND_ADDRESS:10085" \
    --auth none \
    --disable-telemetry \
    $EDITOR_HOME
EOF
