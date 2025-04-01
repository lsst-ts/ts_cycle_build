#!/bin/bash

source /opt/lsst/software/stack/loadLSST.bash

eups list | grep lsst_distrib | awk '{print $4}'

