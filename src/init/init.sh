#!/bin/bash

cd $(dirname $BASH_SOURCE[0]) || exit 1

. ../modules/common.sh

main () {
	import_env_module

	import_environs

	local prompts=(
		"please input 42 api's UID: "
		"please input 42 api's SECRET: "
	)
	local var_names=(
		"API_UID"
		"API_SECRET"
	)

	for i in "${!var_names[@]}"; do
		local value=$(get_value_secret "${prompts[$i]}" "${var_names[$i]}")
		local name="${var_names[$i]}"
		if [ -n "$value" ]; then
			ENV[$name]=$value
		fi
	done
	
	export_environs
}

get_value_secret() {
	local PROMPT="$1"
	local ENV_NAME="$2"

	printf "$PROMPT" > /dev/stderr
	if [ -n "${!ENV_NAME}" ]; then
		printf " (now: ***) " > /dev/stderr
	fi

	read -s "$ENV_NAME"
	echo "" > /dev/stderr
	if [ -z "${!ENV_NAME}" ]; then
		echo 'skip' > /dev/stderr
	fi
	echo "${!ENV_NAME}"
}

get_value() {
	local PROMPT="$1"
	local ENV_NAME="$2"

	printf "$PROMPT" > /dev/stderr
	if [ -n "${!ENV_NAME}" ]; then
		printf " (now: ${!ENV_NAME}) " > /dev/stderr
	fi

	read "$ENV_NAME"
	if [ -z "${!ENV_NAME}" ]; then
		echo 'skip' > /dev/stderr
	fi
	echo "${!ENV_NAME}"
}

main