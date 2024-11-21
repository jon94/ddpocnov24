# NodeJS
- For NodeJS18, we can leverage on local library injection using mutatingwebhookconfigurations to ease the set up process. This is not supported for PHP, which is why for PHP, we need to instrument it on the Dockerfile Layer.
- Please refer to the sample_deployment.yaml in this folder on where you should put labels and annotations for library injection to happen.
- For correlation, Datadog relies on tagging. Specifically, something we call unified service tagging - https://docs.datadoghq.com/getting_started/tagging/unified_service_tagging/?tab=kubernetes#containerized-environment
    -  This can be done directly on the YAML file (see line 5-7, 29-31) in the sample_deployment.yaml in this folder.
- For Datadog webhook to pick up the injection, we will need line 25 and line 27.    