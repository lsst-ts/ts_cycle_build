#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

$RUN_ARG &

pid="$!"

wait ${pid}
