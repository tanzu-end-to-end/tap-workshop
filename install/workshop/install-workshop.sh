set -x

ytt template -f ../../resources -f $1 --ignore-unknown-comments | kapp deploy -n default -a tap-workshop -f- --diff-changes --yes
