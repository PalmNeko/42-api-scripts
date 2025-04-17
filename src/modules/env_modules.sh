#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/common.sh

# import from .env file
import_environs() {
	local PROJECT_PATH=$(get_project_path)
	if [ -f "$PROJECT_PATH/.env" ]; then
		. "$PROJECT_PATH/.env"
	fi

	local var_names=(
		"API_UID"
		"API_SECRET"
		"CAMPUS_ID"
		"CURSUS_ID"
	)

	declare -gA ENV
	for i in "${!var_names[@]}"; do
		local value="${!var_names[$i]}"
		local name="${var_names[$i]}"
		if [ -n "$value" ]; then
			ENV[$name]="$value"
		fi
	done
}

# export to .env file
export_environs() {
	local var_names=(
		"API_UID"
		"API_SECRET"
		"CAMPUS_ID"
		"CURSUS_ID"
	)

	local PROJECT_PATH=$(get_project_path)
	echo '#!/bin/bash' > "$PROJECT_PATH"/.env
	for i in "${!var_names[@]}"; do
		local name="${var_names[$i]}"
		local value="${ENV[$name]}"
		echo $name $value
		if [ -n "$value" ]; then
			echo "$name=$value" >> "$PROJECT_PATH"/.env
		fi
	done
}

need_environs() {
	for arg; do
		if [ -z "${!arg}" ]; then
			err_exit "Error: you have to set $arg"
		fi
	done
}