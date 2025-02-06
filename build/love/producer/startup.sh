#!/bin/bash
. /home/saluser/.setup_sal_env.sh

if [[ -n "$PERIODIC_TOPICS" && -n "$ASYNC_TOPICS" ]]; then
  echo "Starting LOVE producer with set of both periodic and asynchronous data."
  run_love_producer ${LOVE_CSC_PRODUCER} --periodic-data $PERIODIC_TOPICS --asynchronous-data $ASYNC_TOPICS &
elif [[ -n "$PERIODIC_TOPICS" ]]; then
  echo "Starting LOVE producer with set of periodic data."
  run_love_producer ${LOVE_CSC_PRODUCER} --periodic-data $PERIODIC_TOPICS &
elif [[ -n "$ASYNC_TOPICS" ]]; then
  echo "Starting LOVE producer with set asynchronous data."
  run_love_producer ${LOVE_CSC_PRODUCER} --asynchronous-data $ASYNC_TOPICS &
else
  echo "Starting LOVE producer with a full set of topics."
  run_love_producer ${LOVE_CSC_PRODUCER} &
fi


pid="$!"

wait ${pid}
