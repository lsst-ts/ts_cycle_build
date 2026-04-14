#!/usr/bin/bash

source ${HOME}/.setup_sal_env.sh
source ${HOME}/.sal_setup.sh
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$CONDA_PREFIX/lib:/usr/local/lib64:/usr/local/lib"

python ${HOME}/.create_topics_mtm1m3ts.py

/home/saluser/ts_m1m3thermal/ts-M1M3thermald ${RUN_ARG} -c /home/saluser/ts_m1m3thermal/SettingFiles &

pid="$!"

wait ${pid}
