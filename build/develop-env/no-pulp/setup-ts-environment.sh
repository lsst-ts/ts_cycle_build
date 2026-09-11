#!/usr/bin/env bash

set -Eeuo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 CONDA_ENVIRONMENT" >&2
    exit 2
fi

environment=$1
checkout_root=${TSSW_PATH:-/opt/lsst/tssw}
checkout_helper=${CHECKOUT_HELPER:-$(cd "$(dirname "$0")" && pwd)/checkout_repo.sh}

if ! command -v conda >/dev/null 2>&1; then
    echo "conda is not available on PATH" >&2
    exit 1
fi
if [[ ! -x "$checkout_helper" ]]; then
    echo "Checkout helper is not executable: $checkout_helper" >&2
    exit 1
fi
if ! conda run -n "$environment" true >/dev/null 2>&1; then
    echo "Conda environment does not exist or cannot run: $environment" >&2
    exit 1
fi

export checkout_root checkout_helper
conda run -n "$environment" --no-capture-output bash -s -- "$checkout_root" "$checkout_helper" <<'SETUP'
set -Eeuo pipefail

checkout_root=$1
checkout_helper=$2
repo_base=${REPO_BASE:-https://github.com/lsst-ts}

mkdir -p "$checkout_root"
cd "$checkout_root"

install_repo() {
    local repo=$1
    local ref=$2
    local mode=$3

    if [[ -e "$repo" && ! -d "$repo/.git" ]]; then
        echo "Not a git checkout: $checkout_root/$repo" >&2
        return 1
    fi
    if [[ ! -d "$repo/.git" ]]; then
        git clone "$repo_base/$repo.git" "$repo"
    fi

    cd "$checkout_root/$repo"
    bash "$checkout_helper" "$ref"

    case "$mode" in
        current)
            eups declare -r . -t current
            ;;
        named)
            eups declare -m none -r . "$repo" "$ref"
            uv pip install --no-deps .
            ;;
        editable)
            eups declare -r . -t current
            uv pip install -e . --no-deps
            ;;
        *)
            echo "Unknown install mode: $mode" >&2
            return 1
            ;;
    esac
    cd "$checkout_root"
}

ref() {
    local variable=$1
    printf '%s' "${!variable:-develop}"
}

while IFS=: read -r repo variable; do
    install_repo "$repo" "$(ref "$variable")" current
done <<'CONFIG_REPOS'
ts_config_ocs:ts_config_ocs
ts_config_attcs:ts_config_attcs
ts_config_mtcalsys:ts_config_mtcalsys
ts_config_eas:ts_config_eas
ts_config_latiss:ts_config_latiss
ts_config_mttcs:ts_config_mttcs
ts_config_atcalsys:ts_config_atcalsys
ts_idl:ts_idl
ts_xml:ts_xml
ts_sal:ts_sal
CONFIG_REPOS

while IFS=: read -r repo variable; do
    install_repo "$repo" "$(ref "$variable")" named
done <<'UTILITY_REPOS'
ts_utils:ts_utils
ts_idl:ts_idl
ts_salobj:ts_salobj
UTILITY_REPOS

while IFS=: read -r repo variable; do
    install_repo "$repo" "$(ref "$variable")" editable
done <<'RUNTIME_REPOS'
ts_scriptqueue:ts_scriptqueue
ts_observatory_control:ts_observatory_control
ts_standardscripts:ts_standardscripts
ts_auxtel_standardscripts:ts_auxtel_standardscripts
ts_maintel_standardscripts:ts_maintel_standardscripts
ts_externalscripts:ts_externalscripts
ts_atmcs:ts_atmcs
ts_atdome:ts_atdome
ts_atdometrajectory:ts_atdometrajectory
ts_attcpip:ts_attcpip
ts_simactuators:ts_simactuators
ts_hexrotcomm:ts_hexrotcomm
ts_tcpip:ts_tcpip
ts_criopy:ts_criopy
ts_m1m3_utils:ts_m1m3_utils
ts_planning_tool:ts_planning_tool
RUNTIME_REPOS
SETUP
