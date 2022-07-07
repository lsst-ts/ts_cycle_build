#!/usr/bin/env bash

# run application
source $HOME/.setup_sal_env.sh
echo "# Starting test CSC with index $RUN_ARG"

run_test_csc $RUN_ARG &

pid="$!"

# wait forever
wait ${pid}

