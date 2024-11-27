#!/usr/bin/env bash

source $HOME/miniconda3/bin/activate

run_audiotrigger $RUN_ARG &

pid="$!"

wait ${pid}
