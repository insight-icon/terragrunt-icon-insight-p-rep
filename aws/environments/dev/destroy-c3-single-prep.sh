#!/usr/bin/env bash
set -e
# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

DIRECTORIES=( \
"us-east-1/bots/rhizome-icon-node-monitor" \
"us-east-1/firewalls/lambda-sg-cron-t3" \
"us-east-1/network/nlb" \
"us-east-1/network/nlb-sg-grpc" \
"us-east-1/sentry/asg" \
"us-east-1/sentry/sg" \
"us-east-1/sentry/data" \
"us-east-1/p-rep/dns-c1" \
"us-east-1/p-rep/ec2" \
"us-east-1/p-rep/keys" \
#"us-east-1/p-rep/sg" \
"us-east-1/data" \
"us-east-1/bastion/sg" \
"us-east-1/logging/log-config-bucket" \
"us-east-1/network/vpc" \
"us-east-1/sentry/packer" \
"global/profiles/p-rep" \
)

for i in "${DIRECTORIES[@]}"
do
   terragrunt destroy --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir $i
done
