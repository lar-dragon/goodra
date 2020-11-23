#!/usr/bin/env bash

eval "docker-compose exec -u laradock workspace ${*:-"bash"}"
