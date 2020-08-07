#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

echo "# Starting ATSpectrograph CSC"

atspec_csc.py $RUN_ARG && \
echo "# ATSpectrograph finished." || \
(echo "# ATSpectrograph failed."; exit 1)
