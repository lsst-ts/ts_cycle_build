#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

LSST_USER_HOME=/home/saluser
unset S3_ENDPOINT_URL

setup lsst_distrib
setup obs_lsst
setup -t current ctrl_oods

csc $RUN_ARG &

pid="$!"

wait ${pid}
