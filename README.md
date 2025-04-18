# 42-api-scripts
42 api scripts


# USAGE
```sh
bash run_42apishell.sh
```

# COMMANDS
run command with `--help` option if you want details
these commands are included at bin/ directory.

* get_campus : get 42 campus list

# ENVIRONS

* API_UID: 42 api's application UID. can't refer it from 42apishell
* API_SECRET: 42 api's application SECRET. can't refer it from 42apishell
* API_TOKEN: 42 api's access token.

# EXAMPLE

get projects filtered by closed , not terminated, not evaluated, cursus:42cursus and campus:42Tokyo in 2025
```
get_teams -r closed_at=2025-01-01,2025-12-31 -s -created_at -f status="waiting_for_correction" -f cursus=21 -f terminating=false -f campus=26 -n 100 | jq
```
