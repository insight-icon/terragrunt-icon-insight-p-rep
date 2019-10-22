#!/usr/bin/env bash
set -e
# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

OKRED='\033[91m'
OKGREEN='\033[92m'
OKORANGE='\033[93m'
RESET='\e[0m'

. ./inventory.sh

for i in "${DIRECTORIES[@]}"
do
    echo -e "$OKRED*****************************************************************$RESET"
	echo -e "$OKRED*$RESET$OKORANGE \t Applying $i\t \t $RESET$OKRED$RESET"
	echo -e "$OKRED*****************************************************************$RESET"

    AWS_REGION=us-east-1 terragrunt apply --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir $i
    echo $i >> ./log.txt
done
