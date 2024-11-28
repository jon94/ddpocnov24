# This guide is to enumerate the number of steps required to configure the Datadog Agent as documented here: Secrets Management - https://docs.datadoghq.com/agent/configuration/secrets-management/?tab=linux

## Requirements
Security concern: secrets / passwords must not be stored in clear to prevent leaks with people having access to root

## Prerequisites
Latest Datadog Agent v7 installed in a Linux VM / Host

## Steps by Steps guide
 
Create secrets folder in /etc/datadog-agent
```
sudo mkdir /etc/datadog-agent/secrets
```
Change owner and permissions to dd-agent
```
sudo chown dd-agent /etc/datadog-agent/secrets
sudo chmod 700 /etc/datadog-agent/secrets
```
Create secrets.py script from the code below
```
#!/usr/bin/env python3
import json
import sys
secret_request = json.load(sys.stdin)
secret_response = {}
secrets = { "secret1": "secret1_val", "secret2": "secret2_val" }
for secret in secret_request["secrets"]:
    if secret in secrets.keys():
      secret_response[secret] = dict({"value": str(secrets[secret]), "error": None})
    else:
      secret_response[secret] = dict({"value": None, "error": "Unable to retrieve secret."})
sys.stdin.close()
print(json.dumps(secret_response))
```
Change owner and permissions to dd-agent
```
sudo chown dd-agent /etc/datadog-agent/secrets/secrets.py
sudo chmod 700 /etc/datadog-agent/secrets/secrets.py
```
Update Datadog Agent configuration: /etc/datadog-agent/datadog.yaml
```
# secret_backend_command: <COMMAND_PATH>
secret_backend_command: /etc/datadog-agent/secrets/secrets.py
```
Extend the secrets that need to be used in the main config file on in the integrations
```
secrets = { "apikey": "MYAPIKEY", "netapp_username": "netappuser", "netapp_password": "password01" }
```
Update Datadog Agent configuration to link the apikey secret file in /etc/datadog-agent/datadog.yaml
```
# api_key
api_key: ENC[apikey]
```