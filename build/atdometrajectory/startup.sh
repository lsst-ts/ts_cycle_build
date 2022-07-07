#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATDomeTrajectory CSC"

run_atdometrajectory &

pid="$!"

wait ${pid}
