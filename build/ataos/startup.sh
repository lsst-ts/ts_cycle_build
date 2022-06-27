#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_ataos_csc &

pid="$!"

wait ${pid}
