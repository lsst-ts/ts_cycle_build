#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

echo "# Starting MTMount CSC"
run_mtmount.py $RUN_ARG
echo "# CSC exited."
