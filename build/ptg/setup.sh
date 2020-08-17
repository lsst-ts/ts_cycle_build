#!/usr/bin/env bash

source $OSPL_HOME/release.com
source /home/saluser/.bashrc

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

trap 'kill ${!}; term_handler' SIGTERM

if [ "$TELESCOPE" == "MT" ]
then
    echo "# Running main telescope pointing component..."
    /home/saluser/repos/ts_pointing_common/build/bin/MTPtgController &
    pid="$!"
elif [ "$TELESCOPE" == "AT" ]
then
    echo "# Running auxiliary telescope pointing component..."
    /home/saluser/repos/ts_pointing_common/build/bin/ATPtgController &
    pid="$!"
else
    echo "# Unrecognized telescope selection ${TELESCOPE}. Must be one of MT or AT"
    exit 1
fi

wait ${pid}
