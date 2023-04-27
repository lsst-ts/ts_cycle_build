#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

setup lsst_distrib
setup cwfs -t current
setup ts_wep -t current
setup atmospec -t $USER
setup summit_utils -t $USER
setup summit_extras -t $USER
setup ts_observing_utilities -t $USER
setup ts_observatory_control
setup ts_externalscripts
setup ts_standardscripts
setup ts_scriptqueue

echo Setting up shared observing environment from ${OBS_ENV_PATH}/auto_env_setup.sh

source ${OBS_ENV_PATH}/auto_env_setup.sh

run_script_queue ${RUN_ARG} &

pid="$!"

wait ${pid}
