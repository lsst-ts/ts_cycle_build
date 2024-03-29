#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

run_salkafka_producer --broker  $BROKER_IP:$BROKER_PORT \
                      --registry  $REGISTRY_ADDR \
                      --partitions  $PARTITIONS \
                      --loglevel $LOG_LEVEL \
                      --replication-factor $REPLICATION \
                      --wait-ack $WAIT_ACK \
                      --username $TS_SALKAFKA_USERNAME \
                      --password $TS_SALKAFKA_PASSWORD \
                      $CSC_LIST  &

pid="$!"

wait ${pid}
