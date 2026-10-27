#!/usr/bin/env bash

source /opt/lsst/software/stack/conda/etc/profile.d/conda.sh
ENV_NAME=$(cat /tmp/env_name)
conda activate "${ENV_NAME}"
setup ts_config_ocs -j -t current
setup ts_config_atcalsys -j -t current
setup ts_config_mtcalsys -j -t current
setup ts_config_attcs -j -t current
setup ts_config_mttcs -j -t current
setup ts_config_eas -j -t current
setup ts_config_latiss -j -t current
