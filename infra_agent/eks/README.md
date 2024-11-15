# EKS Agent Installation

- Please go through this [guided tour](https://datadog.navattic.com/ui10b8i) to see how you can install and validate the agent on a kubernetes based set up.

## eks-values.yaml

- Feel free to use the eks-values.yaml file that is provided in the repo.
- Creating Datadog API Key and APP Key as Kubernetes Secret
```
kubectl create namespace datadog
kubectl create secret generic datadog-secret -n datadog --from-literal api-key=<DATADOG_API_KEY> --from-literal app-key=<DATADOG_APP_KEY>
```