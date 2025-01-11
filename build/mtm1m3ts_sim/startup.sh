#!/usr/bin/bash

source ${HOME}/.setup_sal_env.sh
source ${HOME}/.sal_setup.sh
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/lsst/ts_sal/lib/

python ${HOME}/.create_topics_mtm1m3ts.py

/home/saluser/ts_m1m3thermal/ts-M1M3thermald ${RUN_ARG} -c /home/saluser/ts_m1m3thermal/SettingFiles &

pid="$!"

wait ${pid}
