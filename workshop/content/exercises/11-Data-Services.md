We didn't talk about this in the previous sections, but Cody's application uses a relational database backend. Let's see how database connections are managed in Tanzu Application Platform.

The right side of the screen in Cody's application shows the database connection string. When Cody was iterating in his local environment, he didn't have a database set up, so the application defaulted to connecting to an embedded in-memory database (hsqldb):

![In-Memory Database](images/hsqldb.png)

But when Alana scheduled the build, she added a section to the `Workload` resource called a **service claim**:

```editor:select-matching-text
file: /home/eduk8s/gitops-workloads/workload-{{ session_namespace }}.yaml
text: "serviceClaims"
before: 0
after: 5
```

The service claim is a declaration that the application intends to connect to a data service, in this case a MySQL database with the identifier `sensors-db`. But Alana doesn't know the credentials for the database, and in fact the credentials will differ depending on whether this is a production or non-production deployment.

This abstraction allows a separate DBA team to manage the credentials for the data service. When the application is deployed, Tanzu Application Platform implements a **service binding** process that injects the data service credentials into the running application as environment variables.

Review the application that has been deployed in the runtime environment:

```dashboard:open-url
url: https://spring-sensors-{{ session_namespace}}-default.{{ ENV_VIEW_CLUSTER_DOMAIN }}
```

If you look at the connection string on the right side, you can now see that the application is connected to a MySQL database called `sensors-mysql`, and is storing persistent data.
