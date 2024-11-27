#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting EAS CSC"

run_eas $RUN_ARG &

pid="$!"

wait ${pid}
