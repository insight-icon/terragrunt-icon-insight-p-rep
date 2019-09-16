#!/usr/bin/env bash

# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

DIRECTORIES=( \
"global/profiles/p-rep" \
"global/profiles/citizen" \
"us-east-1/network/vpc" \
"us-east-1/services/eks"
)

for i in "${DIRECTORIES[@]}"
do
   terragrunt apply --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir$i
done
