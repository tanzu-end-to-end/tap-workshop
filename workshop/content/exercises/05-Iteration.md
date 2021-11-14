## Iteration

So Cody now has a running deployment, and it conforms to the compliance standards that Alana defined. But Cody's just getting started. The supply chain is repeatable, so each new commit that Cody makes to the codebase will trigger another execution of the supply chain.

![Iterate](images/iterate.png)

Let's make a code change

```editor:select-matching-text
file: spring-sensors/src/main/java/org/tanzu/demo/DemoController.java
text: "_webProperties.getBannerText()"
```

We've selected the variable that determines the banner text at the top of the Web UI. Click below to replace the selectedtext with a static constant.

```editor:replace-text-selection
file: spring-sensors/src/main/java/org/tanzu/demo/DemoController.java
text: REPLACEMENT_BANNER_TEXT
```

Optionally, you can overwrite this static constant to display whatever text you like:

```editor:select-matching-text
file: spring-sensors/src/main/java/org/tanzu/demo/DemoController.java
text: "Tanzu Application Platform Demo"
```

Now, let's commit the change to the Git repo that is being monitored by our supply chain:

```execute
git -C ~/spring-sensors commit -a -m "Application Change"
```

```execute
git -C ~/spring-sensors push -u origin main
```

Wait a moment, and the supply chain will kick off. You will be able to see the build and deploy progress in the bottom terminal window. After the deploy, you can verify it is complete by again running:

```execute
tanzu apps workload get spring-sensors
```

You will see the second build process listed for the build you triggered with your application update. The State for that build pod should show **Succeeded**. You can once again click on the URL displayed for your application Service, and we will see our code changes reflected in the deployed version.
