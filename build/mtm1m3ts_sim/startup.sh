#!/usr/bin/bash

source ${HOME}/.crio_setup.sh

python ${HOME}/.create_topics_mtm1m3ts.py

/home/saluser/ts_m1m3thermal/ts-M1M3thermald ${RUN_ARG} -c /home/saluser/ts_m1m3thermal/SettingFiles &

pid="$!"

wait ${pid}
