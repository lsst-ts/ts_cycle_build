#!/usr/bin/env bash

# Source this file when starting the container to set it up

echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib

# Set up the AOS related packages
LSST_USER_HOME=/home/saluser
AOS_REPOS=${LSST_USER_HOME}/repos

cd ${AOS_REPOS}/phosim_utils/
setup -k -r .

cd ${AOS_REPOS}/ts_wep/
setup -k -r .

cd ${AOS_REPOS}/ts_ofc/
setup -k -r .

cd ${AOS_REPOS}/ts_phosim/
setup -k -r .

# Back to the default directory
cd ${LSST_USER_HOME}

# Execute the file in the interactive environment
/bin/bash --rcfile ${LSST_USER_HOME}/.bashrc
