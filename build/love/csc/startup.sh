#!/bin/bash
. /home/saluser/.setup_sal_env.sh

run_love_csc &

pid="$!"

wait ${pid}
