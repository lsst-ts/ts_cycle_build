#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_ess_csc $RUN_ARG &

pid="$!"

wait ${pid}
