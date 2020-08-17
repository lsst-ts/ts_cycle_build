#!/usr/bin/env bash

source $OSPL_HOME/release.com
source /home/saluser/.bashrc

if [ "$TELESCOPE" == "MT" ]
then
    echo "# Running main telescope pointing component..."
    /home/saluser/repos/ts_pointing_common/build/bin/MTPtgController && \
    echo "# Maint telescope pointing component finished." || \
    (echo "# Error in MTPtg execution." && exit 1)
elif [ "$TELESCOPE" == "AT" ]
then
    echo "# Running auxiliary telescope pointing component..."
    /home/saluser/repos/ts_pointing_common/build/bin/ATPtgController && \
    echo "# Auxiliary telescope pointing component finished." || \
    (echo "# Error in ATPtg execution." && exit 1)
else
    echo "# Unrecognized telescope selection ${TELESCOPE}. Must be one of MT or AT"
    exit 1
fi
