#!/bin/bash

# -e : fail as soon as a command errors out 
# -u : unset variables are treated as errors
# -x : print each command before execution (debug tool)
# -o pipefail : fail as soon as any command in pipeline errors out
set -euo pipefail

#############################################################################
# Cache the plugins
#############################################################################
mkdir -p ~/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
export TF_INPUT=0

#############################################################################
# Setting variables
#############################################################################
CONFIG_DIR="./configs"
VERSION=$(< "$CONFIG_DIR/VERSION")

#############################################################################
# Runtime variables
#############################################################################
OKRED='\033[91m'
OKGREEN='\033[92m'
OKORANGE='\033[93m'
RESET='\e[0m'

CONFIG=""
OPS=""

declare -a STACK
NUM_STEPS=0

#############################################################################
# Functions 
#############################################################################

# Arguments: None
function check_deps() {
	# Check terraform which is a dependency
	command -v terraform >/dev/null 2>&1 || \
		{ echo >&2 "Requires terraform to run, but is not installed. Aborting!"; exit 1; }

	# Check terragrunt which is a dependency
	command -v terragrunt >/dev/null 2>&1 || \
		{ echo >&2 "Requires terragrunt to run, but is not installed. Aborting!"; exit 1; }

	# Check terragrunt which is a dependency
	command -v ansible >/dev/null 2>&1 || \
		{ echo >&2 "Requires ansible to run, but is not installed. Aborting!"; exit 1; }

	# Check jq which is a dependency
	command -v jq >/dev/null 2>&1 || \
		{ echo >&2 "Requires jq to run, but is not installed. Aborting!"; exit 1; }
}

# Arguments: None
function show_usage() {
	echo -e "Version: $VERSION"
	echo -e "Usage:"
	echo -e "  $0 <config> <ops>"
	echo ""
	echo -e "arguments:"
	echo -e "  <config> : Deployment configuration to use"
	echo -e "  <ops>    : 'apply' or 'destroy'"
	echo ""
}

# Arguments: Config, Operation and Current Step
function show_current_step() {
	echo ""
	echo -e "$OKRED**********************************************************$RESET"
	echo -e "$OKRED*$RESET$OKORANGE Configuration:$RESET$OKGREEN $1 $RESET"
	echo -e "$OKRED*$RESET$OKORANGE Operation:$RESET$OKGREEN $2 $RESET"
	echo -e "$OKRED*$RESET$OKORANGE Step:$RESET$OKGREEN $3 $RESET"
	echo -e "$OKRED**********************************************************$RESET"
	echo ""
}

#############################################################################
# Entry Point 
#############################################################################

# Check dependencies
check_deps

# If no arguments, show usage, and exit
[[ -z "$*" ]] && show_usage && exit 1

# Parse the arguments
CONFIG="$1"
OPS="$2"

# Required arguments not present. Exit. 
[[ "${CONFIG}" == "" ]] && show_usage && exit 1
[[ "${OPS}" == "" ]] && show_usage && exit 1

# If the config directory does not exist, abort.
[[ ! -d "$CONFIG_DIR" ]] && { echo >&2 "Configuration directory not found. Aborting!"; exit 1; }

# If the config specified does not exist, abort.
CONFIG_PATH="$CONFIG_DIR/$CONFIG.json"
[[ ! -f "$CONFIG_PATH" ]] && { echo >&2 "Configuration at $CONFIG_PATH not found. Aborting!"; exit 1; }

# Make sure it is a valid json file. If not, abort.
jq -e "." "$CONFIG_PATH" > /dev/null 2>&1 || { echo >&2 "$CONFIG_PATH is not a valid JSON file. Aborting!"; exit 4; }

# Read in the stack
while read -r line;
do
	STACK+=("$line")
done < <(jq -rc ".stack[]" "$CONFIG_PATH")

# Number of steps in the stack
NUM_STEPS=${#STACK[@]}

# Apply the steps for configuration given for specified operation
case "${OPS}" in
	"apply")
		for (( i = 0 ; i < NUM_STEPS; i++))
		do
			show_current_step "${CONFIG}" "${OPS}" "${STACK[i]}"
			terragrunt apply --terragrunt-source-update \
				--terragrunt-non-interactive \
				--auto-approve \
				--terragrunt-working-dir "${STACK[i]}"
		done
	;;
	"destroy")
		for (( i = NUM_STEPS - 1 ; i >= 0; i--))
		do
			show_current_step "${CONFIG}" "${OPS}" "${STACK[i]}"
			terragrunt destroy --terragrunt-source-update \
				--terragrunt-non-interactive \
				--auto-approve \
				--terragrunt-working-dir "${STACK[i]}"
		done
	;;
	*)
		echo "Unknown operation. Aborting!"
		exit 1
	;;
esac
