#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_genericcamera $RUN_ARG &

pid="$!"

wait ${pid}
