#!/bin/bash
set -x
set +e

export REPO_NAME=$SESSION_NAMESPACE-$(date +%s)
echo $REPO_NAME > repo.txt

mkdir spring-sensors
cd spring-sensors
echo "# Spring Sensors Application" >> README.MD
git init
git checkout -b main
git config user.name gitea_admin
git config user.email "gitea_admin@example.com"
git add .
git commit -a -m "Initial Commit"

git remote add origin https://gitea_admin:$GITEA_PASSWORD@gitea.${INGRESS_DOMAIN}/gitea_admin/$REPO_NAME.git
git push -u origin main

cd ..
git clone https://gitea_admin:$GITEA_PASSWORD@gitea.${INGRESS_DOMAIN}/gitea_admin/gitops-workloads.git
envsubst < workload.yaml > gitops-workloads/workload-$SESSION_NAMESPACE.yaml
rm workload.yaml
