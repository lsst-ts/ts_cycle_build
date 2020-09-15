#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting MTDomeTrajectory CSC"

run_mtdometrajectory.py &

pid="$!"

wait ${pid}
