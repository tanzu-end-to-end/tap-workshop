Until now, we have focused on the actions a new developer would take to set up a project in Tanzu Application Platform. However, once she has completed her work and pushed the results to the appropriate branch in git, the TAP supply chain takes over.

The supply chain is managed by the **Supply Chain Choreographer (SCC)** component of TAP, which is VMware's commercial distribution of the Cartographer open source project. Cartographer and SCC are purpose built for managing the complete software supply chain cycle, from initial development through deployment to Kubernetes. A compliment to existing CI and CD tools (though it can certainly be used for that purpose), Cartographer is designed to coordinate across all tools involved in sourcing, building, testing, verifying, and deploying a software project.

# What is a supply chain?

Supply chains are simply a set of working components composed into an ordered set of operations. Supply chains monitor the work of each components, and handle forwarding work from one component (say, Jenkins) to the next (say, TBS).

To explore our supply chain, let's take a look at the supply chain definition we are using for "web" applications:

```editor:open-file
file: supplychain/supplychain.yaml
```
There are a few things to highlight in this file.

1. The ```spec/app.tanzu.vmware.com/workload-type``` entry defines that tag that will be used in the workload.yaml file of any application that utilizes this supply chain.
2. The ```components``` section has a sequential list of all components used by the supply chain.

To understand what each component does, you can take a look at the supplychain-tempates.yaml file:

```editor:open-file
file: supplychain/supplychain-templates.yaml
```

This file contains the definition of each supply chain resource. For example, the first resource is named ```git-repository-battery``` and leverages Flux to monitor and act on changes to our git repository. Similarly, ```kpack-battery``` utilizes kpack in conjunction with TBS to build and package the image.

Now let's add the workload to the TAP supply chain automation.

```execute
tanzu apps workload create spring-sensors -f spring-sensors/config/workload.yaml -y
```

#Monitoring the build

For our demonstration, we are simply going to use the Tanzu command line to watch the logs:

```execute
tanzu apps workload tail spring-sensors
```

When the build is complete, the container images are stored in a Harbor registry, from which deployment operations will pull those images. Let's now look at how TAP automates the deployment and execution of our application.app