#!/usr/bin/env bash


source ${WORKDIR}/.setup_sal_env.sh

setup ts_ataos -t current

echo "# Starting ATAOS CSC"

ataos_csc.py $RUN_ARG && \
echo "# ATAOS finished." || \
(echo "# ATAOS failed."; exit 1)
