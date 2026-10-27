#!/bin/bash

#########################################################################
# Helper script to install the LabJack system library as root user and  #
# the labjack-ljm conda package as saluser user.                        #
#                                                                       #
# This script is used by:                                               #
#   - build/develop-env/no-stack/Dockerfile                             #
# so modifying this script may affect building that Docker image.       #
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
                conda_environment=*)
                    # The Conda environment to install the package into
                    conda_environment=${OPTARG#*=}
                    ;;
                labjack_ljm=*)
                    # The version of the labjack-ljm conda package to install
                    labjack_ljm=${OPTARG#*=}
                    ;;
            esac;;
    esac
done

: "${conda_environment:?--conda_environment is required}"
: "${labjack_ljm:?--labjack_ljm is required}"

yum -y --enablerepo=extras install epel-release unzip

cd /tmp
arch="$(uname -m)"

if [[ "$arch" == "x86_64" ]]; then
  url="https://files.labjack.com/installers/LJM/Linux/x64/release/LabJack-LJM_2025-05-07.zip"
elif [[ "$arch" == "aarch64" ]]; then
  url="https://files.labjack.com/installers/LJM/Linux/AArch64/release/LabJack-LJM_2025-05-07.zip"
else
  echo "Unsupported architecture: $arch" >&2
  exit 1
fi

curl -fL -O "$url"
unzip LabJack-LJM_2025-05-07.zip
./labjack_ljm_installer.run -- --without-kipling --no-restart-device-rules # || echo "Expected failure! can't restart rules on docker."
rm labjack_ljm_installer.run
rm INSTALL.md

runuser -u saluser -- conda install -y \
  -n "${conda_environment}" "labjack-ljm=${labjack_ljm}"
