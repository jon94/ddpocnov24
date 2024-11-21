# Dockerfile

- The instrumentation for PHP applications will be introduced in the Dockerfile Layer. An example can be seen in Dockerfile from line 23-32.
- Official Datadog Document - https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/php/ 

# Sample deployment file for kubernetes
- The main focus area here is Line 35-39. Where we rely on Kubernetes [Downward API](https://kubernetes.io/docs/concepts/workloads/pods/downward-api/) to propagate DD_AGENT_HOST. 