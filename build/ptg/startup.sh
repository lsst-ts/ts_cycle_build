#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

ospl_release_string=$(ospl -v)
ospl_release_pattern='OpenSplice version : (.*)'
[[ "$ospl_release_string" =~ $ospl_release_pattern ]]

export OSPL_RELEASE=${BASH_REMATCH[1]}

if [ "$TELESCOPE" == "MT" ]
then
    echo "# Running main telescope pointing component..."
    /home/saluser/repos/ts_pointing_common/build/bin/MTPtgController &
    pid="$!"
elif [ "$TELESCOPE" == "AT" ]
then
    echo "# Running auxiliary telescope pointing component..."
    /home/saluser/repos/ts_pointing_common/build/bin/ATPtgController &
    pid="$!"
else
    echo "# Unrecognized telescope selection ${TELESCOPE}. Must be one of MT or AT"
    exit 1
fi

wait ${pid}
