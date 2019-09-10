#!/usr/bin/env bash

# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache

DIRECTORIES=( \
"global/profiles/p-rep" \
"global/profiles/citizen" \
"global/audit/cloudtrail" \
"global/audit/s3-cloudtrail" \
"us-east-1/logging/log-config-bucket" \
"us-east-1/p-rep/keys" \
"us-east-1/p-rep/sg" \
"us-east-1/p-rep/ec2" \
"us-east-1/network/vpc" \
"us-east-1/citizen/keys" \
"us-east-1/citizen/sg" \
"us-east-1/citizen/ec2" \
)

for i in "${DIRECTORIES[@]}"
do
   terragrunt destroy --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir $i
done

## TODO: Turn into array + loop
#terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir global
#terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/network
#terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/logging
#terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/citizen
#terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/p-rep



