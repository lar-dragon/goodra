#!/usr/bin/env bash

function export_envs() {
    local key
    local temp
    local preset
    local value
    local isComment
    local isBlank
    local isPath

    isComment="^[[:space:]]*#"
    isBlank="^[[:space:]]*$"
    isPath="^[[:space:]]*/"

    while IFS="=" read -r key temp || [ -n "${key}" ]
    do
        [[ "${key}" =~ ${isComment} ]] && continue
        [[ "${key}" =~ ${isBlank} ]] && continue

        preset=$(eval "echo \"\$${key}\"")

        [[ -n "${preset}" ]] && continue

        value=${preset:-$(eval "echo ${temp}")}

        [[ "$value" =~ ${isPath} ]] && value="/${value}"

        eval "export $key=\"${value}\"";
    done < "${1:-".env"}"
}

function goodra() {
    local work_path
    local script_path
    local project
    local command
    local project_path
    local project_name
    local work_path_env
    local script_path_env
    local project_path_env

    work_path="$(pwd)"
    script_path="$(dirname "${1}")"
    project=${2:-"."}
    command=${3:-"init"}

    if [ "${project}" = "." ]
    then
        project_path="${work_path}/goodra"
        project_name="$(basename "${work_path}")"
    else
        project_path="${HOME}/.goodra/${project}"
        project_name="${project}"
    fi

    mkdir -p "${project_path}"
    cp -n -a "${script_path}/default/." "${project_path}"

    work_path_env="${work_path}/.env"
    script_path_env="${script_path}/.env"
    project_path_env="${project_path}/.env"

    test -f "${work_path_env}" && export_envs "${work_path_env}"
    test -f "${script_path_env}" && export_envs "${script_path_env}"
    test -f "${project_path_env}" && export_envs "${project_path_env}"

    if [ -x "${project_path}/${command}.sh" ]
    then
        pushd "${project_path}" || exit 1
        export APP_CODE_PATH_HOST=${work_path}
        export COMPOSE_PROJECT_NAME=${project_name}
        export PHP_IDE_CONFIG="serverName=${project_name}"
        eval "./${command}.sh ${*:4}"
        popd || exit 1
    else
        echo "Command \"${command}\" not defined"
    fi
}

eval "goodra ${0} ${*}"
