#!/usr/bin/env bash

source $WORKDIR/.setup_sal_env.sh

setup ts_ataos -t current

ataos_csc.py &

pid="$!"

wait ${pid}
