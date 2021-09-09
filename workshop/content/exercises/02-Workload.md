The accelerator contains a template for creating a cloud-native application that is compliant with Alana's enterprise governance standards, and the workload.yaml file for interfacing with Tanzu Application Platform. Cody does not need to provide any other configuration files, such as Dockerfiles or Kubernetes resources, that have dependencies on the target application infrastructure.

The workflow here is that Cody downloads the accelerator template to his local machine, customizes to his needs, and then publishes it to a Git Repo where we can hand off to Alana.

![Accelerator to Git](images/push-to-git.png)

For this demo, we'll use the command line instead of the Web UI to download the Spring Sensors application accelerator.

```execute
curl acc-ui-server.accelerator-system/api/accelerators/zip?name=spring-sensors -H 'Content-Type: application/json' -d '{"options":{"projectName":"spring-sensors","bannerText":"Tanzu Sensor Database","bannerColor":"Salmon"}}' -o spring-sensors.zip
```

Unzip the repo into your local file system:

```execute
unzip -o spring-sensors.zip && envsubst < spring-sensors/config/workload.yaml > spring-sensors/config/tmp.yaml && mv spring-sensors/config/tmp.yaml spring-sensors/config/workload.yaml
```

Commit the configured application to Git, where it can be picked up by Tanzu Application Platform:

```execute
git -C ~/spring-sensors add ~/spring-sensors/
```

```execute
git -C ~/spring-sensors commit -a -m "Initial Commit of Spring Sensors"
```

```execute
git -C ~/spring-sensors push -u origin main
```

Now Cody executes the *workload create* command to publish his new application to Tanzu Application Platform.

```execute
tanzu apps workload create spring-sensors -f spring-sensors/config/workload.yaml -y
```

Let's see where Alana takes it from here!
