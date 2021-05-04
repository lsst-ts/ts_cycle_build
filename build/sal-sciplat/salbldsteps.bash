# This just saves us some repetition in SAL setup scripts
source ${LOADSTACK}
unset LD_PRELOAD
setup lsst_distrib

source ${OSPL_HOME}/release.com

export OSPL_URI=$(python -c "from lsst.ts import ddsconfig; print( (ddsconfig.get_config_dir() / 'ospl-sp.xml').as_uri())")
