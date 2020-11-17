#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_dsm.py --index=${CSC_INDEX} ${RUN_ARG} &

pid="$!"

wait ${pid}
