#!/usr/bin/env bash
set -e
# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

DIRECTORIES=( \
"us-east-1/p-rep/lambda-sg-cron"
"us-east-1/p-rep/ec2" \
"us-east-1/p-rep/keys" \
"us-east-1/p-rep/sg" \
"us-east-1/network/vpc" \
"global/profiles/citizen" \
"global/profiles/p-rep" \
)

for i in "${DIRECTORIES[@]}"
do
   terragrunt destroy --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir $i
done
