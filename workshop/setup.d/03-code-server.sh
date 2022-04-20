#!/bin/bash
set -x
set +e

cat <<'EOF' > /home/eduk8s/.local/share/code-server/User/settings.json
{
    "redhat.telemetry.enabled": false,
    "java.server.launchMode": "Standard",
    “tanzu.sourceImage”: “harbor.tap.amer.end2end.link/tap/tanzu-java-web-app-source”,
    "terminal.integrated.automationShell.linux": "/bin/bash",
    "workbench.startupEditor": "none",
    "update.showReleaseNotes": false,
    "python.autoUpdateLanguageServer": false,
    "extensions.autoCheckUpdates": false,
    "extensions.autoUpdate": false,
    "update.mode": "none",
    "python.linting.enabled": false
}
EOF

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
