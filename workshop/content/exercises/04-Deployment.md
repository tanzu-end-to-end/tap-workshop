At this point, our onboarding developer simply needs to verify that her application was packaged and deployed. We can do this by using the Harbor registry to verify packages have been built and are available, and the Tanzu CLI to verify the workloads are deployed and running. We can also leverage Tanzu's powerful App Live View dashboard to verify ongoing operations.

## Verify Packaging

Once the supply chain completes building and packaging Spring Sensors, it is pushed to the Harbor Registry.

Use the following link to access the Harbor registry:

```dashboard:create-dashboard
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

This command provides details on our application, including the URL associated with the Knative Serving (which is part for Cloud Native Runtimes for VMware Tanzu) Service that provides Ingress to our application. Click on the URL in the terminal window to open our application in a browser window.

## Monitor Operations

Cody can now use the Tanzu Application Platform GUI to get more information about his deployed workloads. Click here to access the TAP GUI

```dashboard:open-url
name: Live
url: https://tap-gui.{{ ingress_domain }}
```

TAP GUI provides a great deal of information about running software deployed through TAP, but Cody is particularly interested in the App Live View. It provides realtime visibility into his new application. Navigate to App Live View:

```dashboard:open-url
url: https://tap-gui.{{ ingress_domain }}/app-live-view/apps/spring-sensors
```

Click on the top pod row. On the subsequent screen, you can use the "Information Category" dropdown to navigate through detailed troubleshooting data on the Spring Sensors app.
