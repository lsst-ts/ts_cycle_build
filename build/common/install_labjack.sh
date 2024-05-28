#!/bin/bash

#########################################################################
# Helper script to install the LabJack system library as root user and  #
# the labjack-ljm conda package as saluser user.                        #
#                                                                       #
# This script is used by:                                               #
#   - build/conda_builder/linux64/Dockerfile                            #
#   - build/develop-env/lsstsqre/Dockerfile                             #
#   - build/ess/Dockerfile                                              #
# so modifying this script may affect building those Docker images.     #
#########################################################################

optspec=":-:"
while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                labjack_arch=*)
                    # The desired architecture, as described in the C library installer's file name
                    labjack_arch=${OPTARG#*=}
                    ;;
                labjack_file_version=*)
                    labjack_file_version=${OPTARG#*=}
                    ;;
                saluser_env_script=*)
                    # The saluser environment script to source
                    saluser_env_script=${OPTARG#*=}
                    ;;
                labjack_ljm=*)
                    # The version of the labjac-ljm conda package to install
                    labjack_ljm=${OPTARG#*=}
                    ;;
            esac;;
    esac
done

yum -y --enablerepo=extras install epel-release unzip

cd /tmp
curl -O https://files.labjack.com/installers/LJM/Linux/x64/release/labjack_ljm_software_${labjack_file_version}_${labjack_arch}.tar.gz
tar -xzf labjack_ljm_software_${labjack_file_version}_${labjack_arch}.tar.gz
cd labjack_ljm_software_${labjack_file_version}_${labjack_arch}
./labjack_ljm_installer.run || echo "Expected failure! can't restart rules on docker."
cd ..
rm -rf labjack_ljm_software_${labjack_file_version}_${labjack_arch}.tar.gz
rm -rf labjack_ljm_software_${labjack_file_version}_${labjack_arch}

cd /tmp
runuser - saluser -c """
source "${saluser_env_script}" && \
conda install -y -c lsstts labjack-ljm=${labjack_ljm}
"""
