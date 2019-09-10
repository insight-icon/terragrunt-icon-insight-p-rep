#!/usr/bin/env bash

# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache

# TODO: Turn into array + loop
terragrunt destroy-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/citizen
terragrunt destroy-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/p-rep
terragrunt destroy-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/logging
terragrunt destroy-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/network
terragrunt destroy-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir global

