#!/usr/bin/env bash

set -Eeuo pipefail

checkout_root=${TSSW_PATH:-/opt/lsst/tssw}
checkout_helper=${CHECKOUT_HELPER:-/home/saluser/.checkout-repo.sh}
repo_base=${REPO_BASE:-https://github.com/lsst-ts}

mkdir -p "$checkout_root"
cd "$checkout_root"
for spec in \
    "ts_scriptqueue:${ts_scriptqueue:-develop}" "ts_observatory_control:${ts_observatory_control:-develop}" \
    "ts_standardscripts:${ts_standardscripts:-develop}" "ts_auxtel_standardscripts:${ts_auxtel_standardscripts:-develop}" \
    "ts_maintel_standardscripts:${ts_maintel_standardscripts:-develop}" "ts_externalscripts:${ts_externalscripts:-develop}" \
    "ts_atmcs:${ts_atmcs:-develop}" "ts_atdome:${ts_atdome:-develop}" \
    "ts_atdometrajectory:${ts_atdometrajectory:-develop}" "ts_attcpip:${ts_attcpip:-develop}" \
    "ts_simactuators:${ts_simactuators:-develop}" "ts_hexrotcomm:${ts_hexrotcomm:-develop}" \
    "ts_tcpip:${ts_tcpip:-develop}" "ts_criopy:${ts_criopy:-develop}" \
    "ts_m1m3_utils:${ts_m1m3_utils:-develop}" "ts_planning_tool:${ts_planning_tool:-develop}"; do
    repo=${spec%%:*}
    ref=${spec#*:}
    git clone "$repo_base/$repo.git"
    cd "$repo"
    bash "$checkout_helper" "$ref"
    eups declare -r . -t current
    cd "$checkout_root"
done
