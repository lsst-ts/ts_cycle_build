#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATHexapod CSC"

run_athexapod $RUN_ARG &

pid="$!"

wait ${pid}
