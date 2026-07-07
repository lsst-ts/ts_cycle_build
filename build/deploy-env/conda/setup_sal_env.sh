#!/usr/bin/env bash

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

${HOME}/.wait_obsenv_sidecar.sh

# setup handlers
# on callback, kill the last background process and execute term_handler
trap 'kill ${!}; term_handler' SIGTERM

${WORKDIR}/miniconda/bin/python -m conda init
source ${WORKDIR}/miniconda/bin/activate

if [ -f "${HOME}/.conda_package_spec.sh" ]; then
  source "${HOME}/.conda_package_spec.sh"
fi
