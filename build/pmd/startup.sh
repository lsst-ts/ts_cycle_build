#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_pmd.py $RUN_ARG &

pid="$!"

wait ${pid}
