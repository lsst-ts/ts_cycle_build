#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

pid="$!"

wait ${pid}
