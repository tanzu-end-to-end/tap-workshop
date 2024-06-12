Sometimes an application isn't behaving quite like we'd expect after deployment, and we want to get more information about its runtime behavior, for diagnostics and troubleshooting. Is our application running out of memory? What was the response time for HTTP Requests?

Tanzu Application Platform provides Live View to help a developer like Cody gather that information. Let's take a look. We're going to access the Web UI known as TAP GUI, which can observe the deployment we just created:

```dashboard:open-url
url: https://tap-gui.{{ ENV_VIEW_CLUSTER_DOMAIN }}/catalog/default/component/spring-sensors/workloads
```

Here we are looking at running deployments of `spring-sensors`, our application. There's a good chance that you see more than one deployment listed! That's because we are in a multitenant development environment, and different developers (or different workshop sessions) are each working on their own branch of the code. In a multi-tenant development cluster (also known as an Iterate cluster in TAP), each developer works in their own namespace for isolation.

Your developer namespace is **{{session_namespace}}**. You can identify which `spring-sensors` app is yours by checking against the namespace column. You can filter the results by choosing your namespace in the namespace column.  Then click on the spring-sensors hyperlink in the row that corresponds to your namespace and the value `Knative Service` in the Kind column. This will bring you to a detail view of your app:

![Component View](images/component-view.png)

If you scroll down in this screen, you will see the Kubernetes resources associated with your app. At the bottom of the screen, you'll find Pods. In Kubernetes, a Pod is where your application container runs. Your pod will have a long, funny name, click on it:

![Pod View](images/pod-view.png)

At the top of the pod info screen, you'll see a detail panel, that provides you quick access to key info about your process. If you click on "View Pod Logs", you will be able to see the application logs from the Kubernetes server where your app is running.

![Pod Detail](images/pod-detail.png)

Scroll down a little bit, and you'll find our Live View pane. It has a menu drop-down called Information Category that allows you to navigate all sorts of data in your Application Runtime.

![Live View](images/live-view.png)

Explore for a little bit, there's a lot to see here. You can check out your application's environment variables, view thread stacktraces, see a graphical view of your memory consumption, see trace info on each HTTP request, and much more.

Live View is currently compatible with Spring Boot Java applications, and Steeltoe .NET Core applications.

Click on the button labelled "Submitting the Build" to continue to the next section of the workshop.
