# Installing Harbor

Ensure that you have prepared a **values.yaml** file, by customizing the values-example.yaml file in the root of this repo.

From this directory in the repo, execute:

```
kubectl create namespace harbor
./install-harbor.sh /path/to/my/values.yaml
```

If you defined a DockerHub proxy cache in your values.yaml, you will need to create it as described [here](https://goharbor.io/docs/2.2.0/administration/configure-proxy-cache/)
