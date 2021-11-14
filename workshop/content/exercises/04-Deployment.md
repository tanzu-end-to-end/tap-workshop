At this point, our onboarding developer simply needs to verify that her application was packaged and deployed. We can do this by using the Harbor registry to verify packages have been built and are available, and the Tanzu CLI to verify the workloads are deployed and running. We can also leverage Tanzu's powerful App Live View dashboard to verify ongoing operations.

## Verify Packaging

Once the supply chain completes building and packaging Spring Sensors, it is pushed to the Harbor Registry.

Use the following link to access the Harbor registry:

```dashboard:open-url
name: Harbor
url: https://harbor.{{ ingress_domain }}
```

You will be redirected to the sign-in page.

* Username: ```admin```
* password ```{{ ENV_HARBOR_PASSWORD }}```

Once you are logged in, click on **tap** in the Projects list, and then click on the **tap/spring-sensors** repo. You will see artifacts for the spring-sensors application. If you want to verify which image is yours, you can check the sha256 for your container image with this command:

```execute
kp image list
```

## Verify Deployment

We can use the Tanzu CLI to verify that the workload has made it through the supply chain:

```execute
tanzu apps workload list
```

Once the status shows **Ready**, let's see how to access our application.

```execute
tanzu apps workload get spring-sensors
```

This command provides details on our application, including the URL associated with the Knative (CNR) Service that provides Ingress to our application. Click on the URL in the terminal window to open our application in a browser window.

## Monitor Operations

One of the more exciting aspects of the TAP platform is its tools for automatically adding and visualizing application monitoring. Access the App Live view here:

```dashboard:open-url
name: Live
url: https://app-live-view.{{ ingress_domain }}
```

Select the dashboard titled spring-sensors-{{ session_namespace }}. Here Cody can get a live view of diagnostic information about his running application, and troubleshoot any issues in the deployment.