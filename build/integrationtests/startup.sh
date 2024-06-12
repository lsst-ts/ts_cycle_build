#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

# Both ENV_EFD and RUN_ARG are defined in the
# workflows/integration-testing/templates/job-workflow-template.yaml
# file in the argocd-csc repo.
 
# Skip the MTCamera tests when running on the BTS,
# until the simulator is implemented.
# Run the CCCamera tests when running on the TTS.
if [[ "${ENV_EFD}" == "base_efd" ]]; then
    skipped="-e bigcamera -e mtocps -e mtptg"
else
    skipped=""
fi

# Execute the given test suite (RUN_ARG value).
robot -A Vars.txt --variable env_efd:$ENV_EFD $skipped $RUN_ARG &

pid="$!"

wait ${pid}

echo "Exit code: $?" && exit 0
