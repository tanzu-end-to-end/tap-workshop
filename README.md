# Tanzu Application Platform Workshop

This is a workshop for delivering a narrative tour of Tanzu Application Platform.

## Installing the Workshop

To install the Tanzu Application Platform workshop in your own environment, the following prereqs must be in place in your Kubernetes cluster:

**Environment Values File**

Follow the docs for [Customizing the Environment Values File](install/values/README.md). Ensure that you have the carvel tools **ytt** and **kapp** installed on your local machine.

**Educates**

Install the educates operator, per these instructions: https://docs-staging.vmware.com/en/Educates/0.0.0/educates-0-0-0/GUID-getting-started-installing-operator.html

**Harbor**

Follow the docs for [Installing Harbor](install/harbor/README.md)

**Tanzu Build Service**

Install Tanzu Build Service per the [Documentation](https://docs.pivotal.io/build-service/1-2/installing.html)

**Gitea**

Follow the docs for [Installing Gitea](install/gitea/README.md)

## Workshop

Finally, follow the docs for [Installing the Workshop](install/workshop/README.md)

The workshop will take a couple of minutes to start. Run:
```
kubectl get eduk8s-training
```
to verify everything is deployed.
