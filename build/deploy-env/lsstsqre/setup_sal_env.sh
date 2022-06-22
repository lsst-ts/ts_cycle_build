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

. ${WORKDIR}/loadLSST.bash

source ${WORKDIR}/ospl_env.sh

source ${OSPL_HOME}/release.com

ospl_release_string=$(ospl -v)
ospl_release_pattern='OpenSplice version : (.*)'
[[ "$ospl_release_string" =~ $ospl_release_pattern ]]

export OSPL_RELEASE=${BASH_REMATCH[1]}

# setup handlers
# on callback, kill the last background process and execute term_handler
trap 'kill ${!}; term_handler' SIGTERM
