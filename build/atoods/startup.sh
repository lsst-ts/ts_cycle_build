#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

setup lsst_distrib
setup ctrl_oods

run_atoods $RUN_ARG &

pid="$!"

wait ${pid}
