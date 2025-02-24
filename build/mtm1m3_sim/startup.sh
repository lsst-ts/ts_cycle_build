#!/usr/bin/bash

source ${HOME}/.setup_sal_env.sh
source ${HOME}/.sal_setup.sh
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/lsst/ts_sal/lib/

/home/saluser/ts_m1m3support/ts-M1M3supportd ${RUN_ARG} -c /home/saluser/ts_m1m3support/SettingFiles &

pid="$!"

wait ${pid}
