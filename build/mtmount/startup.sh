#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

if [[ -z "${CCW_ONLY}" ]]; then
  echo "# Starting MTMount CSC in CCW only mode."
  run_mtmount_ccw_only $RUN_ARG &
else
  echo "# Starting MTMount CSC."
  run_mtmount $RUN_ARG &
fi

pid="$!"

wait ${pid}
