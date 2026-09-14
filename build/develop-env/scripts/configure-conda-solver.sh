#!/usr/bin/env bash

set -Eeuo pipefail

if [[ $# -ne 1 || "$1" != true && "$1" != false ]]; then
    echo "Usage: $0 true|false" >&2
    exit 2
fi

if [[ "$1" == true ]]; then
    conda install -n base -y --solver classic -c conda-forge conda-rattler-solver
    conda config --set solver rattler
else
    conda install -n base -y --solver classic -c conda-forge conda-libmamba-solver
    conda config --set solver libmamba
fi
