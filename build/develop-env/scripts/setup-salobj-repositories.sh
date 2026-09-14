#!/usr/bin/env bash

set -Eeuo pipefail

checkout_root=${TSSW_PATH:-/opt/lsst/tssw}
checkout_helper=${CHECKOUT_HELPER:-/home/saluser/.checkout-repo.sh}
repo_base=${REPO_BASE:-https://github.com/lsst-ts}

install_repo() {
    local spec=$1
    local repo=${spec%%:*}
    local ref=${spec#*:}
    git clone "$repo_base/$repo.git"
    cd "$repo"
    bash "$checkout_helper" "$ref"
    if [[ "$repo" == ts_utils || "$repo" == ts_idl || "$repo" == ts_salobj ]]; then
        python -m pip install --no-deps --ignore-installed -e .
        eups declare -m none -r . "$repo" "$ref"
    else
        eups declare -r . -t current
    fi
    cd "$checkout_root"
}

mkdir -p "$checkout_root"
cd "$checkout_root"
for spec in \
    "ts_config_ocs:${ts_config_ocs:-develop}" "ts_config_attcs:${ts_config_attcs:-develop}" \
    "ts_config_mtcalsys:${ts_config_mtcalsys:-develop}" "ts_config_eas:${ts_config_eas:-develop}" \
    "ts_config_latiss:${ts_config_latiss:-develop}" "ts_config_mttcs:${ts_config_mttcs:-develop}" \
    "ts_config_atcalsys:${ts_config_atcalsys:-develop}" "ts_idl:${ts_idl:-develop}" \
    "ts_xml:${ts_xml:-develop}" "ts_sal:${ts_sal:-develop}" "ts_utils:${ts_utils:-develop}" \
    "ts_salobj:${ts_salobj:-develop}"; do
    install_repo "$spec"
done
