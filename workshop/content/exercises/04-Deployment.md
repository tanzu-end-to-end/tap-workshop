At this point, our onboarding developer simply needs to verify that her application was packaged and deployed.  We can do this by using the Carvel `imgpkg` tool list out the digests for the images have been built and are available, and then use the Tanzu CLI to verify the workloads are deployed and running.  We can also leverage Tanzu's powerful App Live View dashboard to verify ongoing operations.

## Verify Packaging

Once the supply chain completes building and packaging Spring Sensors, it is pushed to a container registry.

Let's use the `imgpkg` tool to list out the tags and digests for our image in the container registry:
```execute
imgpkg tag list --digests -i harbor.{{ ingress_domain }}/tap/supply-chain/spring-sensors-{{ session_namespace }}
```

You should see a listing of any images that have been built for the spring-sensors application.  If you want to verify which image is deployed, you can check the sha256 for your deployed container image with this command:

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

TAP GUI provides a great deal of information about running software deployed through TAP, but Cody is particularly interested in the App Live View. It provides realtime visibility into his new application. Navigate to the Runtime Resources associated with your application:

```dashboard:open-url
url: https://tap-gui.{{ ingress_domain }}/catalog/default/component/spring-sensors/workloads
```

From here, you will drill down on the Knative Service associated with your application, and click on the most recent deployment. On the deployment detail screen, scroll down and click on one of your pods. This will bring you to a detail screen that includes App Live View capabilities. Use the drop-down menu on the App Live View pane to navigate runtime info for your application.

Click on the top pod row. On the subsequent screen, you can use the "Information Category" dropdown to navigate through detailed troubleshooting data on the Spring Sensors app.
