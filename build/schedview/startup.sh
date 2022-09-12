#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

bokeh serve ${HOME}/schedview/schedview/app/sched_maps --address 0.0.0.0 --prefix schedview --num-procs 4 --websocket-max-message-size=2000000000 &

pid="$!"

wait ${pid}
