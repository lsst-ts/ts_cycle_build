#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

echo "# Starting MTMount CSC"
run_mtmount $RUN_ARG &

pid="$!"

wait ${pid}
