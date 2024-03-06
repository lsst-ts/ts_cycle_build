#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

# Run the night report REST API web server.
run_nightreport &

pid="$!"

wait ${pid}
