ARG deploy_tag

FROM lsstts/deploy-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atdometrajectory
ARG idl
ARG config

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atdometrajectory=${atdometrajectory} ts-idl=${idl}

RUN git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/saluser/ts_config_attcs

RUN git checkout ${config} -b ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_ATTCS_DIR=/home/saluser/ts_config_attcs

COPY setup.sh /home/saluser/.setup.sh
