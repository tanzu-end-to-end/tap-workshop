## Install the E2E Workshop

Create a public project called **tanzu-e2e** in your Harbor instance. There is a Dockerfile in the root directory of this repo. From that root directory, build a Docker image and push it to the project you created:
```
docker build . -t harbor.(your-ingress-domain)/tanzu-e2e/eduk8s-tap-workshop
docker push harbor.(your-ingress-domain)/tanzu-e2e/eduk8s-tap-workshop
```

From this directory of the repo, execute the script to install the Metacontrollers. They will manage resources specific to workshop sessions, such as Harbor projects:
```
./install-metacontrollers.sh /path/to/my/values.yaml
```

The workshop demonstrates the binding of a sample application workload to a RabbitMQ Cluster provided by the RabbitMQ Cluster Operator for Kubernetes. Install the operator in your cluster via:
```
./install-rabbit-operator.sh
```

Then, install the Learning Center workshop:
```
./install-workshop.sh /path/to/my/values.yaml
```
