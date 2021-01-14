#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_dsm.py ${CSC_INDEX} ${RUN_ARG} &

pid="$!"

wait ${pid}
