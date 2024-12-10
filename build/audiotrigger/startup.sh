#!/usr/bin/env bash

source $HOME/miniconda3/bin/activate

run_serial_temperature_scanner $RUN_ARG &

pid="$!"

wait ${pid}
