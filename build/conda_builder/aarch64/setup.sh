source ~/miniconda3/bin/activate
source ${HOME}/.ospl_env.sh
source $OSPL_HOME/release.com

export OSPL_URI=$(python -c "from lsst.ts import ddsconfig; print( (ddsconfig.get_config_dir() / 'ospl-std.xml').as_uri())")
export LSST_DDS_DOMAIN_ID=$(( RANDOM % 230 ))
export LSST_DDS_HISTORYSYNC=10
export OSPL_MASTER_PRIORITY=10

/bin/bash --rcfile /home/saluser/.bashrc
