#!/usr/bin/env bash

source $WORKDIR/.setup_sal_env.sh

setup ts_ataos -t current

ataos_csc.py $RUN_ARG &

pid="$!"

wait ${pid}
