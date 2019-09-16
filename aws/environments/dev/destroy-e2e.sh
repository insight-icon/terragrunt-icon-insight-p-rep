#!/usr/bin/env bash
set -e
# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

DIRECTORIES=( \
"us-east-1/services/eks"
"us-east-1/network/vpc" \
"global/profiles/citizen" \
"global/profiles/p-rep" \
)

for i in "${DIRECTORIES[@]}"
do
   terragrunt destroy --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir $i
done
