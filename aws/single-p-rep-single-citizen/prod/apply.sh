#!/usr/bin/env bash

# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache

# TODO: Turn into array + loop
terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir global
terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/network
terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/logging
terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/citizen
terragrunt apply-all --terragrunt-source-update --terragrunt-non-interactive --terragrunt-working-dir us-east-1/p-rep



