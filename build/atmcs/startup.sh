#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATMCS CSC"

run_atmcs $RUN_ARG &

pid="$!"

wait ${pid}
