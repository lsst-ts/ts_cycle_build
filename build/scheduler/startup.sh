#!/usr/bin/env bash

source ${WORKDIR}/.setup_sal_env.sh

setup lsst_sims
setup ts_scheduler

echo "# Running Scheduler with index: ${INDEX}"

run_scheduler.py $INDEX &

pid="$!"

wait ${pid}
