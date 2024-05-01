#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

set -eu

# Update the database schema
alembic upgrade head

# Run the night report REST API web server.
run_nightreport &

pid="$!"

wait ${pid}
