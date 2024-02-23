#!/bin/bash
set -x
set +e

if [ -z ${HARBOR_USER+x} ]; then 
  embedded_reg_creds="learningcenter-registry-credentials"
  if [[ -n ${POLICY_ENGINE} ]]; then 
    embedded_reg_creds="educates-registry-credentials"
  fi
  kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "exported-creds"},{"name": "'$embedded_reg_creds'"}], "secrets": [{"name": "exported-creds"},{"name": "'$embedded_reg_creds'"}]}'
else 
  REGISTRY_USER=${HARBOR_USER:-admin}
  REGISTRY_URL=${REGISTRY_URL:-harbor.${INGRESS_DOMAIN}}
  REGISTRY_PASSWORD=$HARBOR_PASSWORD kp secret create registry-credentials --registry $REGISTRY_URL --registry-user $REGISTRY_USER
fi
