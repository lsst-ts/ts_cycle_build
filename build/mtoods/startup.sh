#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

setup lsst_distrib
setup -t current ctrl_oods
setup obs_lsst -t $USER

mtoods $RUN_ARG &

pid="$!"

wait ${pid}
