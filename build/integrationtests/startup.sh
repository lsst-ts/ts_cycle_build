#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

robot -A Vars.txt $RUN_ARG &

pid="$!"

wait ${pid}

echo "Exit code: $?" && exit 0
