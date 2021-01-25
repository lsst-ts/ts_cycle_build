#!/usr/bin/env bash

source ${WORKDIR}/.setup_sal_env.sh

setup cwfs -t current
setup lsst_distrib
setup obs_base -t $USER
setup pipe_tasks -t $USER
setup rapid_analysis -t $USER
setup atmospec -t $USER
setup ts_observing_utilities -t $USER
setup ts_scriptqueue

run_script_queue.py ${RUN_ARG} &

pid="$!"

wait ${pid}
