#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

echo "# Starting Weather Station CSC with run argument: $RUN_ARG"

environment_csc.py $RUN_ARG &

pid="$!"

wait ${pid}
