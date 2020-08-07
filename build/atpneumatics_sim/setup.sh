#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATPneumatics Simulator CSC"

run_atpneumatics_simulator.py && \
echo "# ATPneumatics Simulator finished." || \
(echo "# ATPneumatics Simulator failed."; exit 1)
