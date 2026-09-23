#!/usr/bin/env bash

set -Eeuo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 CONDA_ENVIRONMENT" >&2
    exit 2
fi

environment=$1
checkout_root=${TSSW_PATH:-/opt/lsst/tssw}
script_dir=$(cd "$(dirname "$0")" && pwd)
checkout_helper=${CHECKOUT_HELPER:-$script_dir/../scripts/checkout-repo.sh}
setup_repositories=${SETUP_REPOSITORIES:-$script_dir/../scripts/setup-ssw-repositories.sh}

for required in "$checkout_helper" "$setup_repositories"; do
    if [[ ! -x "$required" ]]; then
        echo "Required script is not executable: $required" >&2
        exit 1
    fi
done

if ! command -v conda >/dev/null 2>&1; then
    echo "conda is not available on PATH" >&2
    exit 1
fi
if ! conda run -n "$environment" true >/dev/null 2>&1; then
    echo "Conda environment does not exist or cannot run: $environment" >&2
    exit 1
fi

export CHECKOUT_HELPER=$checkout_helper
conda run -n "$environment" --no-capture-output "$setup_repositories" "$checkout_root" "$checkout_helper"
