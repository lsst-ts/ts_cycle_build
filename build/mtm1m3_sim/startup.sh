#!/usr/bin/bash

source ${HOME}/.setup_sal_env.sh

/home/saluser/ts_m1m3support/ts_M1M3Support -d -c /home/saluser/ts_m1m3support/SettingFiles &

pid="$!"

wait ${pid}
