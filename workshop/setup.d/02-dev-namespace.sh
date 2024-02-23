#!/bin/bash
set -x
set +e

if [ -z ${HARBOR_USER+x} ]; then 
  if [[ -z ${POLICY_ENGINE} ]]; then 
    kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "exported-creds"},{"name": "learningcenter-registry-credentials"}], "secrets": [{"name": "exported-creds"},{"name": "learningcenter-registry-credentials"}]}'
  else
    kubectl patch serviceaccount default --type "json" -p '[{"op":"add","path":"/secrets","value":[]},{"op":"add","path":"/secrets/-","value":{"name":"exported-creds"}}]'
  fi
else 
  REGISTRY_USER=${HARBOR_USER:-admin}
  REGISTRY_URL=${REGISTRY_URL:-harbor.${INGRESS_DOMAIN}}
  REGISTRY_PASSWORD=$HARBOR_PASSWORD kp secret create registry-credentials --registry $REGISTRY_URL --registry-user $REGISTRY_USER
fi
