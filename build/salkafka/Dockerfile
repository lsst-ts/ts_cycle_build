ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

RUN dnf install -y iproute

COPY startup.sh /home/saluser/.startup.sh

RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER saluser

RUN source /home/saluser/.setup_sal_env.sh && \
    pip install kafkit[aiohttp] aiokafka

ARG salkafka=v1.1.1

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-salkafka=${salkafka} python-confluent-kafka

COPY m1m3.yaml /home/saluser/m1m3.yaml

LABEL salkafka=${salkafka}

WORKDIR /home/saluser
