#!/usr/bin/env bash
set -e
# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

DIRECTORIES=( \
"global/profiles/p-rep" \
"global/profiles/citizen" \
"us-east-1/network/vpc" \
"us-east-1/logging/log-config-bucket" \
"us-east-1/logging/lb-logging-bucket" \
"us-east-1/citizen/keys" \
"us-east-1/citizen/sg" \
"us-east-1/citizen/ec2-ddos"
"us-east-1/p-rep/keys" \
"us-east-1/p-rep/sg" \
"us-east-1/p-rep/citizen-ddos"
)

for i in "${DIRECTORIES[@]}"
do
   terragrunt apply --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir $i
done

#L4 prod.insight-icon.net:7100 -> NLB
#L7 prod.insight-icon.net/prep -> ALB

