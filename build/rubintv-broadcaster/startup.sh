
source ${WORKDIR}/loadLSST.bash

umask 002

# Perform updates to all repos before script launch
# We start in rubintv_production/scripts and need to return there
cd ../
directories="Spectractor atmospec summit_utils summit_extras rubintv_production eo_pipe"
for directory in ${directories}
do
  cd ../${directory}
  branch=$(git rev-parse --abbrev-ref HEAD)
  git fetch --all
  git checkout ${DEPLOY_BRANCH} && (git reset --hard origin/${DEPLOY_BRANCH}) || (git checkout ${branch} && git reset --hard origin/${branch})
done

cd ../rubintv_production/scripts

setup lsst_distrib
setup spectractor -t saluser
setup atmospec -j -t saluser
setup summit_utils -j -t saluser
setup summit_extras -j -t saluser
setup rubintv_production -j -t saluser
setup eo_pipe -j -t saluser

python $RUN_ARG
