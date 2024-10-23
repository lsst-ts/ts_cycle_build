

umask 002

git config --global --add safe.directory '*'

# Perform updates to all repos before script launch
# We start in rubintv_production/scripts and need to return there
cd ../
directories="obs_lsst drp_pipe Spectractor atmospec summit_utils summit_extras rubintv_production eo_pipe rubintv_analysis_service ts_wep donut_viz"
for directory in ${directories}
do
  echo -e "\nSetting up ${directory}..."
  cd /repos/${directory}
  branch=$(git rev-parse --abbrev-ref HEAD)
  git fetch --all
  git checkout ${DEPLOY_BRANCH} && (git reset --hard origin/${DEPLOY_BRANCH}) || (git checkout ${branch} && git reset --hard origin/${branch})
  commit_info=$(git log -1 --pretty=format:"%h %s")
  echo -e "${directory} is at: ${commit_info}\n"
done

# Move back to the scripts directory
cd "${SCRIPTS_LOCATION:-/repos/rubintv_production/scripts}"

source ${WORKDIR}/loadLSST.bash

setup lsst_distrib
setup -j obs_lsst -t saluser
setup -j drp_pipe -t saluser
setup -j ts_wep -t saluser
setup -j donut_viz -t saluser
setup -j spectractor -t saluser
setup -j atmospec -t saluser
setup -j summit_utils -t saluser
setup -j summit_extras -t saluser
setup -j rubintv_production -t saluser
setup -j rubintv_analysis_service -t saluser
setup -j eo_pipe -t saluser

echo -e "\nOutput of eups list -s | grep tag:saluser:"
eups list -s | grep tag:saluser

python $RUN_ARG
