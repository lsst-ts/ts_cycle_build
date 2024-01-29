#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_rubintv &

pid="$!"

wait ${pid}