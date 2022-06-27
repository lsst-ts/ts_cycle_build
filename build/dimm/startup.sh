#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

echo "# Starting DIMM CSC with run argument: $RUN_ARG"

run_dimm_csc $RUN_ARG &

pid="$!"

wait ${pid}
