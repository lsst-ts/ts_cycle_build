# This just saves us some repetition in SAL setup scripts
source ${LOADSTACK}
unset LD_PRELOAD
setup lsst_distrib
setup ts_salobj -t current
setup ts_observatory_control -t current
setup ts_standardscripts -t current
setup ts_externalscripts -t current
