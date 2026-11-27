#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

vmslogger $RUN_ARG &

pid="$!"

wait ${pid}