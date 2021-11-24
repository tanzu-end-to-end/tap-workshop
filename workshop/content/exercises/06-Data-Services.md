## Data Services
Most applications require backing services, such as databases, queues, and caches, to run successfully.

Tanzu Application Platform makes it easy to discover, curate, consume, and manage such backing services across single or multi-cluster environments. 
This enables developers to spend more time focussing on developing their applications and less time worrying about the provision, configuration, and operations of the backing services they depend on.

This experience is made possible in Tanzu Application Platform by using the **Services Toolkit** component. 

Within the context of Tanzu Application Platform, one of the most important use cases is binding an application workload to a backing service such as a PostgreSQL database or a RabbitMQ queue. 
This use case is made possible by the [Service Binding Specification](https://github.com/k8s-service-bindings/spec) for Kubernetes. 

In our case we have a RabbitMQ cluster provided by the RabbitMQ Cluster Operator for Kubernetes running in the workshop namespace, which is used for asynchronous communication between our application and a sensor application that is also deployed in the workshop namespace.
```execute
kubectl get RabbitmqCluster
```
```execute
tanzu apps workload list
```
For both, the credentials that are required for the connection to the RabbitMQ cluster are injected as environment variables into the containers via a service binding.
```execute
kubectl get ServiceBinding
```
If we have a closer look at one of the ServiceBinding objects, we can see references to a ResourceClaim for the RabbitMQ Cluster and the Knative Serving Service of our application.
```execute
kubectl get ServiceBinding spring-sensors-rmq -o yaml | yq e '.spec' -
```
Additionally, the name of the Kubernetes Secret that includes the credentials for the RabbitMQ cluster is available in the `status.binding` field.
```execute
kubectl get ServiceBinding spring-sensors-rmq -o yaml | yq e '.status.binding' -
```
Behind the scenes, based on those Custom Resource Definitions objects, the Kubernetes Secret that includes the credentials will be mounted to the application containers as a volume.