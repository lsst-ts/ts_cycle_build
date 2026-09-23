#!/usr/bin/env bash

# Source this file when starting the container to set it up

source /home/saluser/.setup_salobj.sh
source /home/saluser/.setup-current.sh

setup ts_atdome -t current
setup ts_atdometrajectory -t current
setup ts_atmcs -t current
setup ts_externalscripts -t current
setup ts_hexrotcomm -t current
setup ts_idl -t current
setup ts_criopy -t current
setup ts_observatory_control -t current
setup ts_planning_tool -t current
setup ts_scriptqueue -t current
setup ts_simactuators -t current
setup ts_standardscripts -t current
setup ts_auxtel_standardscripts -t current
setup ts_maintel_standardscripts -t current
setup ts_tcpip -t current

/bin/bash --rcfile /home/saluser/.bashrc
