As our supply chain completed building and packaging the application, it placed it in a Harbor registry. We can see the application entry by running the command below.

```dashboard:create-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```


Let's check to see if our build is finished deploying. You may run the following command as often as necessary until you see the deployment process complete.

[[[Command to confirm application installation]]]

In this supply chain, deployment ```app``` CRD. You can see the application is deployed using the following command:

```execute
kubectl describe app
```

```kapp``` is great, as it can be used for lifecycle management and provides a single point to deployu and tear down an app and all of it's dependencies. However,

Now let's look at the network details for our application.

[[[ Command to get URL ]]]

If we click on the URL in [[[ tag name ]]], we will see our application deployed and running.