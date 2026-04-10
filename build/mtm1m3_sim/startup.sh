#!/usr/bin/bash

source ${HOME}/.setup_sal_env.sh
export LD_LIBRARY_PATH=/usr/local/lib64/:/usr/local/lib:/opt/lsst/software/stack/miniconda/lib

/home/saluser/ts_m1m3support/ts-M1M3supportd ${RUN_ARG} -c /home/saluser/ts_m1m3support/SettingFiles &

pid="$!"

wait ${pid}
