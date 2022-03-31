#!/bin/bash
set -x
set +e

REGISTRY_PASSWORD=$HARBOR_PASSWORD kp secret create registry-credentials --registry harbor.${INGRESS_DOMAIN} --registry-user ${HARBOR_USER}

