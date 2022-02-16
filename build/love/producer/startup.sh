#!/bin/bash
. /home/saluser/.setup_sal_env.sh

run_love_producer ${LOVE_CSC_PRODUCER} &

pid="$!"

wait ${pid}
