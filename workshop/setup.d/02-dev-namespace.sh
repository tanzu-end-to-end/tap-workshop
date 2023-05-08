#!/bin/bash
set -x
set +e

if [ -z ${HARBOR_USER+x} ]; then 
  kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "exported-creds"},{"name": "learningcenter-registry-credentials"}]}'
else 
  REGISTRY_USER=${HARBOR_USER:-admin}
  REGISTRY_URL=${REGISTRY_URL:-harbor.${INGRESS_DOMAIN}}
  REGISTRY_PASSWORD=$HARBOR_PASSWORD kp secret create registry-credentials --registry $REGISTRY_URL --registry-user $REGISTRY_USER
fi
