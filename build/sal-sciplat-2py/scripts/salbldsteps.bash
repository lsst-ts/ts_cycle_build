# This just saves us some repetition in SAL setup scripts
source ${LOADSTACK}
setup lsst_distrib

export LSST_KAFKA_SECURITY_USERNAME=$(cat ${LSST_KAFKA_PASSFILE} | cut -d: -f1)
export LSST_KAFKA_SECURITY_PASSWORD=$(cat ${LSST_KAFKA_PASSFILE} | cut -d: -f2)
