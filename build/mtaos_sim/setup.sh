#!/usr/bin/env bash

# Source this file when starting the container to set it up

# Add the description
echo "#"
echo "# Loading LSST Stack"
. ${WORKDIR}/loadLSST.bash

source ${WORKDIR}/ospl_env.sh

echo "#"
echo "# Loading sal environment"
source ${OSPL_HOME}/release.com

export PATH=${WORKDIR}/bin:${PATH}

# Set up the AOS related packages
LSST_USER_HOME=/home/saluser
AOS_REPOS=${LSST_USER_HOME}/repos

setup phosim_utils -t current
setup ts_wep -t current
setup ts_ofc -t current
setup ts_phosim -t current
setup ts_MTAOS -t current

echo "#"
