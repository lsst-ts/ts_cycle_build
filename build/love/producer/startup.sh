#!/bin/bash
. /home/saluser/.setup_sal_env.sh

run_love_producer &

pid="$!"

wait ${pid}
