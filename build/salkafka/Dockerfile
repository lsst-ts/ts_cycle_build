ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

RUN yum install -y iproute

COPY startup.sh /home/saluser/.startup.sh

RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER saluser

ARG salkafka=v1.1.1
ARG idl=1.1.3_4.8.0

RUN source /home/saluser/.setup_sal_env.sh && \
    pip install kafkit[aiohttp] aiokafka && \
    conda install -c lsstts ts-salkafka=${salkafka} ts-idl=${idl} python-confluent-kafka

WORKDIR /home/saluser
