#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_weatherforecast $RUN_ARG &

pid="$!"

wait ${pid}
