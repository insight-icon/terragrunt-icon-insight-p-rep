#!/usr/bin/env bash

# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

DIRECTORIES=( \
"us-east-1/citizen/ec2" \
"us-east-1/citizen/sg" \
"us-east-1/citizen/keys" \
"us-east-1/p-rep/ec2" \
"us-east-1/p-rep/sg" \
"us-east-1/p-rep/keys" \
"us-east-1/network/peering-mgmt" \
"us-east-1/network/vpc-mgmt" \
"us-east-1/network/vpc" \
"global/profiles/citizen" \
"global/profiles/p-rep" \
"us-east-1/logging/log-config-bucket" \
)

for i in "${DIRECTORIES[@]}"
do
   terragrunt destroy --terragrunt-source-update --terragrunt-non-interactive -force --terragrunt-working-dir $i
done