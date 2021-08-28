# Configuring the Environment Values File

Make a copy of the [values-example.yaml](values-example.yaml) file, and customize it for the cluster you will be installing the e2e workshop into. You will use this values file as an input to all subsequent install processes.

**ingress.domain**<br>
This is the DNS name for the wildcard domain for which you have configured a signed certificate for Ingress.
**ingress.contour_tls_namespace**<br>
**ingress.contour_tls_secret**<br>
Using `kubectl create secret tls`, create a Kubernetes secret that contains the public cert and the private key for your signed certificate. Set these values to the namespace and the name of your created secret.

**harbor.adminPassword**<br>
Set to the password you choose for the **admin** user in your Harbor server. <br>
**harbor.diskSize**<br>
Set to the size of the PersistentVolumeClaim for the volume that will store your Harbor images.

**gitea.adminPassword**<br>
Set to the password you choose for the **gitea_admin** user in your Gitea server. <br>

**registry.dockerhub**
The workshop will pull DockerHub images for some containers like MySQL. If you are concerned about hitting DockerHub rate limits in a high usage environment, you can change the value of this variable from docker.io to a registry in which you have mirrored the images.

**git.account**<br>
**git.branch**<br>
If you are installing the latest release of the E2E workshop, you can leave this blank. If you want to run a different release (for example, you have forked the workshop to create a customized version), update these values to point to the Git repo for the release you are running.
**git.gitHubToken**
Specifying a gitHubToken will allow you to pull workshop content from a private GitHub repo, and circumvent rate limiting in Harbor's Trivy Scanner