#!/usr/bin/env bash
set -euo pipefail
# Cache the plugins
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

OKRED='\033[91m'
OKGREEN='\033[92m'
OKORANGE='\033[93m'
RESET='\e[0m'

. ./c3.sh

f() { DIRECTORIES=("${BASH_ARGV[@]}"); }

shopt -s extdebug
f "${DIRECTORIES[@]}"
shopt -u extdebug

for i in "${DIRECTORIES[@]}"
do
    echo -e "$OKRED*****************************************************************$RESET"
	echo -e "$OKRED*$RESET$OKORANGE \t Destroying $i\t \t $RESET$OKRED$RESET"
	echo -e "$OKRED*****************************************************************$RESET"
	echo ""
    terragrunt destroy --terragrunt-source-update --terragrunt-non-interactive --auto-approve --terragrunt-working-dir $i
done
