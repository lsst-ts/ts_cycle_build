#!/usr/bin/env bash

source /home/saluser/.setup_salobj.sh

setup ts_config_attcs -t current
setup ts_ataos -t current

ataos_csc.py
