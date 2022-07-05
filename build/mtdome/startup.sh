#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_mtdome $RUN_ARG &

pid="$!"

wait ${pid}
