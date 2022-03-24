# Installing Harbor

Ensure that you have prepared a **values.yaml** file, by customizing the values-example.yaml file in the root of this repo.

From this directory in the repo, execute:

```
kubectl create namespace harbor
./install-harbor.sh /path/to/my/values.yaml
```

If you defined a DockerHub proxy cache in your values.yaml, you will need to create it as described [here](https://goharbor.io/docs/2.2.0/administration/configure-proxy-cache/)

This script will create a load balancer endpoint in the harbor namespace. You will need to create a DNS record (A or CNAME) for harbor.(ingress.domain) that resolves to the load balancer endpoint.