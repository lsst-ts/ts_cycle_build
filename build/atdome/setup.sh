#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATDome CSC"

run_atdome.py $RUN_ARG && \
echo "# ATDome finished." || \
(echo "# ATDome failed."; exit 1)
