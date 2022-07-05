#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

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
