#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

echo "# Starting OCPS CSC"

run_ocps $RUN_ARG &

pid="$!"

wait ${pid}
