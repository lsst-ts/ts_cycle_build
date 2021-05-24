#!/bin/bash
. /home/saluser/.setup_sal_env.sh

python -m aiohttp.web -H 0.0.0.0 -P 5000 commander.app:create_app &

pid="$!"

wait ${pid}
