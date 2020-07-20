ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atdometrajectory
ARG idl
ARG config

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atdometrajectory=${atdometrajectory} ts-idl=${idl}

RUN git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/saluser/ts_config_attcs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_ATTCS_DIR=/home/saluser/ts_config_attcs

LABEL ts-atdometrajectory=${atdometrajectory} \
      ts-idl=${idl} \
      ts_config_attcs=${config}

COPY setup.sh /home/saluser/.setup.sh
