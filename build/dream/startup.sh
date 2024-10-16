#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting DREAM CSC"

run_dream &

pid="$!"

wait ${pid}
