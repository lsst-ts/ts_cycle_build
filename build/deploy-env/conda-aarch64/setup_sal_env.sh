#!/usr/bin/env bash

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process and execute term_handler
trap 'kill ${!}; term_handler' SIGTERM

source ${WORKDIR}/miniforge/bin/activate
source ${HOME}/.ospl_env.sh
# source ${OSPL_HOME}/release.com
