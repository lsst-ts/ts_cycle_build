#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

source $CONDA_PREFIX/HeaderService/setpath.sh $CONDA_PREFIX/HeaderService

headerservice -c $HEADERSERVICE_DIR/etc/conf/${CAMERA}Telemetry.yaml $PORT_SPEC $URL_SPEC &

pid="$!"

wait ${pid}
