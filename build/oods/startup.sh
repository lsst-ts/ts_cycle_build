#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

LSST_USER_HOME=/home/saluser

setup lsst_distrib
setup -t current ctrl_oods

csc $RUN_ARG &

pid="$!"

wait ${pid}
