set -x

ytt template -f ../../resources -f $1 --ignore-unknown-comments | kapp deploy -n tap-install -a tap-workshop -f- --diff-changes --yes

kubectl apply -f additional-resources.yaml