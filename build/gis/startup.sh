#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

# This is necessary to add here because the store folder is only available at deploy time and not at build time.
mkdir /home/saluser/.ssh && \
cp /home/saluser/.store/* /home/saluser/.ssh/ # Put the patched ssh keys into the ssh folder

run_gis $RUN_ARG &

pid="$!"

wait ${pid}
