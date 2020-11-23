#!/usr/bin/env bash

docker-compose up -d ${LARADOCK_SERVICES[@]:-"workspace"}
