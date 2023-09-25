#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

# MICROPHONE_SERVER_HOST and MICROPHONE_SERVER_PORT are defined by the
# deployment system.
run_audio_broadcaster ${MICROPHONE_SERVER_HOST} ${MICROPHONE_SERVER_PORT} &

pid="$!"

wait ${pid}
