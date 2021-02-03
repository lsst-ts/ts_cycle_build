#!/usr/bin/env bash
source $HOME/.setup_sal_env.sh

run_mtrotator.py $RUN_ARG &

pid="$!"

wait ${pid}
