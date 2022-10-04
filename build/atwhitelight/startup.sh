#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_atwhitelight $RUN_ARG &

pid="$!"

wait ${pid}
