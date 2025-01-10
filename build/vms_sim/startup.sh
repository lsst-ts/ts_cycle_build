#!/usr/bin/bash

source ${HOME}/.setup_sal_env.sh
source ${HOME}/.sal_setup.sh
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/lsst/ts_sal/lib/

python ${HOME}/.create_topics_vms.py

/home/saluser/ts_vms/ts-VMSd -c /home/saluser/ts_vms/SettingFiles ${RUN_ARG} &

pid="$!"

wait ${pid}
