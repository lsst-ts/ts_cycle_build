#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_atmonochromator $RUN_ARG &

pid="$!"

wait ${pid}
