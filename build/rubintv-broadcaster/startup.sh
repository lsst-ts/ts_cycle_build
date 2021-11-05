
source ${WORKDIR}/loadLSST.bash

# Perform updates to all repos before script launch
# We start in rapid_analysis/scripts and need to return there
cd ../
directories="Spectractor atmospec rapid_analysis"
for directory in ${directories}
do
  cd ../${directory}
  branch=$(git rev-parse --abbrev-ref HEAD)
  git fetch --all
  git checkout ${branch}
  git reset --hard origin/${branch}
done
cd scripts

setup lsst_distrib
setup atmospec -j -t current
setup rapid_analysis -j -t current 
setup obs_lsst -j -t saluser

python $RUN_ARG
