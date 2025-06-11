#!/usr/bin/env bash

printenv

python3.12 /usr/src/rubin-ToO-producer/forward_alerts.py -f ${HOME}/config.yaml

