#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_electrometer $RUN_ARG &

pid="$!"

wait ${pid}
