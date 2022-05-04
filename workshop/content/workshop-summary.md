We can check the runtime deployment created by the deliverable:

```dashboard:open-url
url: https://spring-sensors-{{ session_namespace}}-default.{{ ENV_VIEW_CLUSTER_DOMAIN }}
```

The supply chains and the deliverables will continually reconcile. When new source code is committed, when security patches for the container images are ingested by Tanzu Build Service, when the architecture team specifies changes in the Convention Service, Supply Chain Choreographer will generate a new deployment definition, which can roll all the way through to the Run clusters.

That concludes our high-level overview of the Tanzu Application Platform.

Want to have more time to take your learning further?  Download and install [Tanzu Community Edition](https://tanzu.vmware.com/tanzu/community) on your development machine in Docker, on virtual machines in a public cloud, or in a private VMware vSphere environment! 

**Tanzu Community Edition** is the free, community-supported, open-source distribution of VMware Tanzu.  It includes a Kubernetes distribution and the **Tanzu Application Toolkit**.  The Tanzu Application Toolkit contains the components needed to orchestrate workload deployments using [Cartographer](https://github.com/vmware-tanzu/cartographer).  You get container image build services provided by [kpack](https://buildpacks.io/docs/tools/kpack/.  And the toolkit includes services to run your workloads using [Knative Serving](https://knative.dev/docs/serving/).

[Tanzu Application Platform](https://tanzu.vmware.com/application-platform) is a software subscription that includes the Application Accelerator, the Learning Center, the Tanzu Application Platform GUI, and  supply chains with integrated container image vulnerability scanning.  You can contact us for a trial of the Tanzu Application Platform by filling out the form at the bottom of the [Tanzu Application Platform](https://tanzu.vmware.com/application-platform) landing page.