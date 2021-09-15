# This just saves us some repetition in SAL setup scripts
source ${LOADSTACK}
unset LD_PRELOAD
setup lsst_distrib
setup ts_salobj -t current
setup ts_observatory_control -t current
setup ts_standardscripts -t current
setup ts_externalscripts -t current

source ${OSPL_HOME}/release.com

export OSPL_URI=$(python -c "from lsst.ts import ddsconfig; print( (ddsconfig.get_config_dir() / 'ospl-shmem.xml').as_uri())")
