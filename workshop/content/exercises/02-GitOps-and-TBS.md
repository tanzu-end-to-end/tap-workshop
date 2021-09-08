Until now, we have focused on the actions a new developer would take to set up a project in Tanzu Application Platform. However, once she has completed her work and pushed the results to the appropriate branch in git, the TAP supply chain takes over.

The supply chain is managed by the **Supply Chain Choreographer (SCC)** component of TAP, which is VMware's commercial distribution of the Cartographer open source project. Cartographer and SCC are purpose built for managing the complete software supply chain cycle, from initial development through deployment to Kubernetes. A compliment to existing CI and CD tools (though it can certainly be used for that purpose), Cartographer is designed to coordinate across all tools involved in sourcing, building, testing, verifying, and deploying a software project.

To explore our supply chain, let's return to the Application Accelerator service and view the supply chain accelerator there:

[```https://accelerator.amer.end2end.link/dashboard/```](https://accelerator.amer.end2end.link/dashboard/)

Once again, TAP is providing a way for users to share approved templates for projects, though in this case the projects are supply chain definitions and the users are application operators and platform teams. Application operators can create new supply chains that adhere to key corporate standards by downloading an approved accelerator.

As we did with the appliation, let's use the command line to download the accelerator.

[[[command to download supply chain accelerator]]]

TAP supply chains have the concept of a component, which is an abstract representation of some software that can take some action on behalf of the project. In the supply chain project, ```supplychain.yaml``` defines the flow of the supply chain, indicating which components are executed in what order. 

```editor:open-file
file: [[[supplychain.yaml]]]
``` 

Note the ```components:``` tag towards the bottom of the file. The list that tag contains is the list of components to take action in sequential order. [[[Need more detail here.]]] The components are defined in a bit more detail in the ```supplychain-templates.yaml``` file.

```editor:open-file
file: [[[supplychain-templates.yaml]]]
```

This will trigger our workload to begin working its way through the supply chain. We can watch the build process here:

```execute-2
kp build logs spring-sensors-image
```


When the build is complete, the container images are stored in a Harbor registry, from which deployment operations will pull those images. Let's now look at how TAP automates the deployment and execution of our application.app