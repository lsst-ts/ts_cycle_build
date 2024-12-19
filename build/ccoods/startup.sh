#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

unset S3_ENDPOINT_URL

setup lsst_distrib
setup -t current ctrl_oods

ccoods $RUN_ARG &

pid="$!"

wait ${pid}
