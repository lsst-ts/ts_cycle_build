#!/usr/bin/env bash

source ${WORKDIR}/.setup_sal_env.sh

setup ts_scriptqueue

run_script_queue.py ${RUN_ARG}
