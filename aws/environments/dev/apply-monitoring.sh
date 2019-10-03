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
"us-east-1/network/vpc-services" \
"us-east-1/network/peering-main-services" \
"us-east-1/bastion/sg" \
#"us-east-1/network/peering-mgmt" \
"us-east-1/network/dns" \
"us-east-1/logging/log-config-bucket" \
"us-east-1/consul/keys" \
"us-east-1/consul/ec2" \
"us-east-1/consul/dns" \
"us-east-1/services/eks" \
"us-east-1/p-rep/keys" \
"us-east-1/p-rep/sg" \
"us-east-1/p-rep/ec2-monitoring" \
"us-east-1/citizen/keys" \
"us-east-1/citizen/sg" \
"us-east-1/citizen/ec2-monitoring" \
)

#"us-east-1/network/vpc-mgmt" \
#"us-east-1/network/peering-mgmt" \

for i in "${DIRECTORIES[@]}"
do
   terragrunt apply --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir $i
done
