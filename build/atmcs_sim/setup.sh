#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATMCS Simulator CSC"

run_atmcs_simulator.py && \
echo "# ATMCS Simulator finished." || \
(echo "# ATMCS Simulator failed."; exit 1)
