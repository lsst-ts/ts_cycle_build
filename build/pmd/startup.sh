#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_pmd $RUN_ARG &

pid="$!"

wait ${pid}
