#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

setup lsst_distrib
setup -t current ctrl_oods

atoods $RUN_ARG &

pid="$!"

wait ${pid}
