# This just saves us some repetition in SAL setup scripts
source ${LOADSTACK}
unset LD_PRELOAD
setup lsst_distrib
setup ts_salobj -t current
setup ts_observatory_control -t current
setup ts_standardscripts -t current
setup ts_auxtel_standardscripts -t current
setup ts_maintel_standardscripts -t current
setup ts_externalscripts -t current

export LSST_KAFKA_SECURITY_USERNAME=$(cat ${LSST_KAFKA_PASSFILE} | cut -d: -f1)
export LSST_KAFKA_SECURITY_PASSWORD=$(cat ${LSST_KAFKA_PASSFILE} | cut -d: -f2)
