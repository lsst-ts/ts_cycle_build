#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

genicam_loc=vimba/VimbaGigETL/CTI/x86_64bit
pyver=$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')

export GENICAM_GENTL64_PATH=${CONDA_PREFIX}/lib/python${pyver}/site-packages/${genicam_loc}

run_genericcamera $RUN_ARG &

pid="$!"

wait ${pid}
