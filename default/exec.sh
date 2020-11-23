#!/usr/bin/env bash

command=$*
eval "docker-compose exec -u laradock workspace ${command:="bash"}"
