#!/usr/bin/env bash
set -x

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  echo Sleeping for 10s
  sleep 10
  echo Exiting
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; term_handler' SIGTERM

# run application
source $HOME/.setup_sal_env.sh
echo Starting test CSC with index $RUN_ARG

run_test_csc.py $RUN_ARG &

pid="$!"

# wait forever
wait ${pid}

