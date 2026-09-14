#!/usr/bin/env bash

set -Eeuo pipefail

checkout_root=${1:?checkout root required}
checkout_helper=${2:?checkout helper required}
repo_base=${REPO_BASE:-https://github.com/lsst-ts}

install_repo() {
    local repo=$1 ref=$2 mode=$3
    if [[ -e "$checkout_root/$repo" && ! -d "$checkout_root/$repo/.git" ]]; then
        echo "Not a git checkout: $checkout_root/$repo" >&2
        return 1
    fi
    [[ -d "$checkout_root/$repo/.git" ]] || git clone "$repo_base/$repo.git" "$checkout_root/$repo"
    cd "$checkout_root/$repo"
    bash "$checkout_helper" "$ref"
    case "$mode" in
        current) eups declare -r . -t current ;;
        named) eups declare -m none -r . "$repo" "$ref"; uv pip install --no-deps . ;;
        editable) eups declare -r . -t current; uv pip install -e . --no-deps ;;
        *) echo "Unknown install mode: $mode" >&2; return 1 ;;
    esac
}

cd "$checkout_root"
while IFS=: read -r repo variable; do
    install_repo "$repo" "${!variable:-develop}" current
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
    install_repo "$repo" "${!variable:-develop}" named
done <<'UTILITY_REPOS'
ts_utils:ts_utils
ts_idl:ts_idl
ts_salobj:ts_salobj
UTILITY_REPOS

while IFS=: read -r repo variable; do
    install_repo "$repo" "${!variable:-develop}" editable
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
