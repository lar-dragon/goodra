#!/usr/bin/env bash

eval "docker-compose up -d ${LARADOCK_SERVICES:-"workspace"}"
