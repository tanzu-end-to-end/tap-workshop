## Install the E2E Workshop

Create a public project called **tanzu-e2e** in your Harbor instance. There is a Dockerfile in the root directory of this repo. From that root directory, build a Docker image and push it to the project you created:
```
docker build . -t harbor.(your-ingress-domain)/tanzu-e2e/eduk8s-tap-workshop
docker push harbor.(your-ingress-domain)/tanzu-e2e/eduk8s-tap-workshop
```

Then, install the Educates workshop:
```
./install-workshop.sh /path/to/my/values.yaml
```
