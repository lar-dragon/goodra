#!/usr/bin/env bash

docker-compose exec -u laradock workspace "${1:-bash}" ${@:2}
