#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

ataos_csc.py &

pid="$!"

wait ${pid}
