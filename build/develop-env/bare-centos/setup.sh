#!/usr/bin/env bash

source /home/saluser/.pyenv.env

pyenv global 3.7.6

source /home/saluser/.ospl.env
source /home/saluser/repos/ts_sal/setup.env
source /opt/rh/devtoolset-8/enable

export PYTHON_BUILD_VERSION=3.7m
export PYTHON_BUILD_LOCATION=/home/saluser/.pyenv/shims
export PYTHON_INCLUDE_DIR=/home/saluser/.pyenv/versions/3.7.6/include/python3.7m
