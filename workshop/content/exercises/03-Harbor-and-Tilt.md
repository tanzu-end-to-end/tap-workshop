As our supply chain completed building and packaging the application, it placed it in a Harbor registry. We can see the application entry by running the command below.

Use the following link to sign into the Harbor Web UI with the username "admin" and password "{{ ENV_HARBOR_PASSWORD }}". (You will be redirected to the sign-in page)

```dashboard:create-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```

Let's navigate to the repo where the supply chain published the image:

```dashboard:reload-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```

Verify that the workload has made it through the supply chain:

```execute
tanzu apps workload list
```

Now let's look at the how to access our application.

```execute
kubectl get ksvc -o=jsonpath='{.items[0].status.url}{"\n"}'
```

This command generates the URL for our running the application. If we click on the URL in the terminal, we can begin using it.
