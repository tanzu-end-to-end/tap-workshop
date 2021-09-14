## Iteration

So Cody now has a running deployment, and it conforms to the compliance standards that Alana defined. But Cody's just getting started. The supply chain is repeatable, so each new commit that Cody makes to the codebase will trigger another execution of the supply chain.

![Iterate](images/iterate.png)

Let's make a code change

```editor:select-matching-text
file: spring-sensors/src/main/java/org/tanzu/demo/DemoController.java
text: "_webProperties.getBannerText()"
```

We've selected the variable that determines the banner text at the top of the Web UI. Click below to replace the selectedtext with the string "Tanzu Application Platform Demo", or replace the text yourself with whatever you like.

```editor:replace-text-selection
file: spring-sensors/src/main/java/org/tanzu/demo/DemoController.java
text: ""Tanzu Application Platform Demo""
```

Now, let's commit the change to the Git repo that is being monitored by our supply chain:

```execute
git -C ~/spring-sensors commit -a -m "Application Change"
```

```execute
git -C ~/spring-sensors push -u origin main
```

The supply chain will kick off. Let's see what's happening with the Knative service that is being managed by Cloud Native Runtime:

```execute
kn service list
```

Initially, the LATEST revision column will show ```spring-sensors-service-0001```, the first deployment of our application. Refresh the command until the supply chain has completed deployment, and it will show ```spring-sensors-service-0002``` as the latest revision. At this point, we can click on the service URL, and we will see our code changes reflected in the deployed application.