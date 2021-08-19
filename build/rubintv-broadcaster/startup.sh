
source ${WORKDIR}/loadLSST.bash

setup lsst_distrib
setup atmospec -j -t current
setup rapid_analysis -j -t current 

python $RUN_ARG
