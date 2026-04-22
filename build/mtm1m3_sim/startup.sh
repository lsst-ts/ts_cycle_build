#!/usr/bin/bash

source ${HOME}/.crio_setup.sh

python ${HOME}/.create_topics_mtm1m3.py

/home/saluser/ts_m1m3support/ts-M1M3supportd ${RUN_ARG} -c /home/saluser/ts_m1m3support/SettingFiles &

pid="$!"

wait ${pid}
