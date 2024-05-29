#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_epm $RUN_ARG &

pid="$!"

wait ${pid}
