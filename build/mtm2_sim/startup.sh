#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

echo "# Starting M2 CSC"
run_mtm2.py $RUN_ARG &

pid="$!"

wait ${pid}
