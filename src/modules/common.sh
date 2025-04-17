#!/bin/bash


# desc: print error message and exit.
# usage: err_exit msg
err_exit() {
	echo "$1" > /dev/stderr
	exit 1
}

# desc: import shell script from file into now shell
# ex: import file
import() {
	if [ -z "$1" ]; then
		err_exit "Error: import function need args"
	fi
	if [ -f "$1" ]; then
		. "$1"
	else
		err_exit "Error: $1: No such file or directory"
	fi
	. "$1"
}

import_env_module() {
	import $(dirname $BASH_SOURCE[0])/env_modules.sh
}

get_project_path() {
	local PROJECT_PATH="$(cd $(dirname ${BASH_SOURCE[0]}) && cd ../../ && pwd)"
	if [ -z "$PROJECT_PATH" ]; then
		err_exit "Error: can't get project path"
	fi
	echo "$PROJECT_PATH"
}