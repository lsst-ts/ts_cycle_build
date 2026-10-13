#!/usr/bin/env bash

source /opt/lsst/software/stack/conda/etc/profile.d/conda.sh
ENV_NAME=$(cat /tmp/env_name)
conda activate "${ENV_NAME}"
setup ts_config_ocs -t current
setup ts_config_atcalsys -t current
setup ts_config_mtcalsys -t current
setup ts_config_attcs -t current
setup ts_config_mttcs -t current
setup ts_config_eas -t current
setup ts_config_latiss -t current
