#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_ledprojector $RUN_ARG &

pid="$!"

wait ${pid}
