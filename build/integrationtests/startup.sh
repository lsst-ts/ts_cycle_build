#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

# Both ENV_EFD and RUN_ARG are defined in the
# workflows/integration-testing/templates/job-workflow-template.yaml
# file in the argocd-csc repo.
 
# Execute the given test suite (RUN_ARG value).
robot -A Vars.txt --variable env_efd:$ENV_EFD $skipped $RUN_ARG &

pid="$!"

wait ${pid}

echo "Exit code: $?" && exit 0
