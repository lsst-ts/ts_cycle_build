#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

shutdown_dsm ${CSC_INDEX} --state offline
