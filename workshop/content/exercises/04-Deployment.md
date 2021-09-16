At this point, our onboarding developer simply needs to verify that her application was packaged and deployed. We can do this by using the Harbor registry to verify packages have been built and are available, and the Tanzu CLI to verify the workloads are deployed and running. We can also leverage Tanzu's powerful App Live View dashboard to verify ongoing operations.

## Verify Packaging

Once the supply chain completes building and packaging Spring Sensors, it is pushed to the Harbor Registry.

Use the following link to access the Harbor registry:

```dashboard:create-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```

You will be redirected to the sign-in page.

* Username: ```admin```
* password ```{{ ENV_HARBOR_PASSWORD }}```

Let's navigate to the repo where the supply chain published the image:

```dashboard:reload-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```

## Verify Deployment

We can use the Tanzu CLI to verify that the workload has made it through the supply chain:

```execute
tanzu apps workload list
```

Now let's look at the how to access our application.

```execute
kubectl get ksvc -o=jsonpath='{.items[0].status.url}{"\n"}'
```

This command generates the URL for our running application. If we click on the URL in the terminal, we can begin using it.

## Monitor Operations

One of the more exciting aspects of the TAP platform is its tools for automatically adding and visualizing application monitoring. Access the App Live view here:

```dashboard:create-dashboard
name: Live
url: https://appview.{{ ingress_domain }}
```
