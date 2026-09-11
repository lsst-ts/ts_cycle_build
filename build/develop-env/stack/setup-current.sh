#!/usr/bin/env bash

set -Eeuo pipefail

for product in \
    ts_config_atcalsys ts_config_attcs ts_config_eas ts_config_latiss \
    ts_config_mtcalsys ts_config_mttcs ts_config_ocs ts_sal ts_salobj ts_xml; do
    setup "$product" -t current
done
