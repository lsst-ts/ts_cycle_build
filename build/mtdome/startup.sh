#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_mtdome.py $RUN_ARG &

pid="$!"

wait ${pid}
