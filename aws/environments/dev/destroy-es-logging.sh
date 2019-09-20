#!/usr/bin/env bash
set -e
# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

DIRECTORIES=( \
"us-east-1/logging/elasticsearch"
"us-east-1/logging/elasticsearch-sg" \
"us-east-1/network/peering-mgmt" \
"us-east-1/network/peering-main-logging" \
"us-east-1/network/vpc-mgmt" \
"us-east-1/network/vpc-logging" \
"us-east-1/network/vpc" \
)

for i in "${DIRECTORIES[@]}"
do
   terragrunt destroy --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir $i
done
