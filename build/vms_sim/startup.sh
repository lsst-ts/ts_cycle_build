#!/usr/bin/bash

source ${HOME}/.crio_setup.sh

python ${HOME}/.create_topics_vms.py

/home/saluser/ts_vms/ts-VMSd -c /home/saluser/ts_vms/MTVMS/v1 ${RUN_ARG} -f
