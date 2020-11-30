#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

echo "# Starting DIMM CSC with run argument: $RUN_ARG"

dimm_csc.py $RUN_ARG &

pid="$!"

wait ${pid}
