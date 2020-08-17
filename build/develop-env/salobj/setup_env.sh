#!/usr/bin/env bash

# Source this file when starting the container to set it up

source ${WORKDIR}/loadLSST.bash

PYTHON_BUILD_VERSION=$(find /opt/lsst/software/stack -name Python.h \
                        2>/dev/null | head -1 | xargs dirname | \
                        xargs basename | sed 's/python//')
export PYTHON_BUILD_VERSION
pdir=$(dirname $(which python3))
PYTHON_BUILD_LOCATION=${pdir:0:-4}
export PYTHON_BUILD_LOCATION
PYTHON_INCLUDE_DIR="${PYTHON_BUILD_LOCATION}/include"
PYTHON_INCLUDE_DIR="${PYTHON_INCLUDE_DIR}/python${PYTHON_BUILD_VERSION}"
export PYTHON_INCLUDE_DIR

source ${WORKDIR}/ospl.env

if [ -f "/home/saluser/repos/ts_sal/setup.env" ]; then
    source /home/saluser/repos/ts_sal/setup.env
else
    source ${OSPL_HOME}/release.com
fi

# Work around for setting LSST_DDS_IP working on most systems
export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'`

export PATH=/opt/lsst/software/bin:${PATH}
