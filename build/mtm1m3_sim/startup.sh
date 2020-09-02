#!/usr/bin/bash

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

source ${OSPL_HOME}/release.com
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/lsst/ts_sal/lib/

trap 'kill ${!}; term_handler' SIGTERM

/home/saluser/ts_m1m3support/ts_M1M3Support -d -c /home/saluser/ts_m1m3support/SettingFiles &

pid="$!"

wait ${pid}
