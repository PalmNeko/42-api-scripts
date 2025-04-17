#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../modules/common.sh

get_token() {
	import_env_module

	import_environs

	need_environs "API_UID" "API_SECRET"

	curl -X POST --data "grant_type=client_credentials&client_id=$API_UID&client_secret=$API_SECRET" https://api.intra.42.fr/oauth/token
}

get_token