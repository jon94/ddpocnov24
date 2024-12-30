#!/bin/bash

export DATADOG_API_KEY=XXXXXXX
export DD_ENV=<set the env here>
export DD_SERVICE=<set service here>

DD_API_KEY=$DATADOG_API_KEY \
bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

sudo -u dd-agent -g dd-agent touch /etc/datadog-agent/environment
sudo chown $(whoami) /etc/datadog-agent/environment
cat <<EOT > /etc/datadog-agent/environment
DD_SERVICE=$DD_SERVICE 
DD_ENV=$DD_ENV 
DD_VERSION=1.0.0
DD_APM_ENABLED=true 
DD_APM_NON_LOCAL_TRAFFIC=true 
EOT
sudo chown dd-agent /etc/datadog-agent/environment

sudo chown $(whoami) /etc/datadog-agent/datadog.yaml
sudo cat <<EOT > /etc/datadog-agent/datadog.yaml
api_key: $DATADOG_API_KEY
env: <ENV>
tags:
  - service:<DD_SERVICE>
apm_config:
  compute_stats_by_span_kind: true
  peer_tags_aggregation: true  
logs_enabled: true  
process_config:
  process_collection:
    enabled: true
EOT
sudo chown dd-agent /etc/datadog-agent/datadog.yaml

sudo cat <<EOT > /etc/datadog-agent/conf.d/<APP_NAME>.d/conf.yaml
logs:
  - type: file
    path: "<PATH_LOG_FILE>/<LOG_FILE_NAME>.log"
    service: "<APP_NAME>"
    source: "<SOURCE>"
EOT

sudo chown -R dd-agent /etc/datadog-agent/conf.d
# Set directory permissions to allow traversal and read access by the owner and group
sudo chmod -R 750 /etc/datadog-agent/conf.d/<APP_NAME>.d
# Set file permissions to allow only the owner to read and write
sudo chmod -R 640 /etc/datadog-agent/conf.d/<APP_NAME>.d/conf.yaml


# Restart the Datadog Agent
sudo systemctl restart datadog-agent

# Get Datadog Agent Status
sudo systemctl status datadog-agent
