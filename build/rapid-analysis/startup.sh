

umask 002

git config --global --add safe.directory '*'

# Perform updates to all repos before script launch
# We start in rubintv_production/scripts and need to return there
cd ../
directories="obs_lsst drp_pipe Spectractor atmospec summit_utils summit_extras rubintv_production eo_pipe rubintv_analysis_service"
for directory in ${directories}
do
  cd /repos/${directory}
  branch=$(git rev-parse --abbrev-ref HEAD)
  git fetch --all
  git checkout ${DEPLOY_BRANCH} && (git reset --hard origin/${DEPLOY_BRANCH}) || (git checkout ${branch} && git reset --hard origin/${branch})
done

# Move back to the scripts directory
cd "${SCRIPTS_LOCATION:-/repos/rubintv_production/scripts}"

source ${WORKDIR}/loadLSST.bash

setup lsst_distrib
setup obs_lsst -t saluser
setup drp_pipe -t saluser
setup -j spectractor -t saluser
setup -j atmospec -t saluser
setup -j summit_utils -t saluser
setup -j summit_extras -t saluser
setup -j rubintv_production -t saluser
setup -j rubintv_analysis_service -t saluser
setup -j eo_pipe -t saluser

python $RUN_ARG
