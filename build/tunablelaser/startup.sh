#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_tunablelaser $RUN_ARG &

pid="$!"

wait ${pid}
