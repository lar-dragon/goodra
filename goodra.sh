#!/usr/bin/env bash

work_path="$(pwd)"
script_path="$(dirname "${0}")"
project=$1
project="${project:="."}"
command=$2
command="${command:="init"}"

if [ "${project}" = '.' ]
then
    project_path="${work_path}/goodra"
    project_name="$(basename "${work_path}")"
else
    project_path="${HOME}/.goodra/${project}"
    project_name="${project}"
fi

mkdir -p "${project_path}"
cp -n -a "${script_path}/default/." "${project_path}"

if [ -x "${project_path}/${command}.sh" ]
then
    pushd "${project_path}" || exit 1
    set -o allexport
    . .env
    set +o allexport
    export APP_CODE_PATH_HOST="${work_path}"
    export COMPOSE_PROJECT_NAME="${project_name}"
    export PHP_IDE_CONFIG="serverName=${project_name}"
	eval ". ${command}.sh ${*:3}"
	popd || exit 1
else
	echo "Command \"${command}\" not defined"
fi
