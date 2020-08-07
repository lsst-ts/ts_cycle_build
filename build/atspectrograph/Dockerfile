ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atspec
ARG idl
ARG config

RUN git clone https://github.com/lsst-ts/ts_config_latiss.git

WORKDIR /home/saluser/ts_config_latiss

RUN /home/saluser/.checkout_repo.sh ${config}

ENV TS_CONFIG_LATISS_DIR=/home/saluser/ts_config_latiss
ENV RUN_ARG=""

WORKDIR /home/saluser/

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atspec=${atspec} ts-idl=${idl}

LABEL ts_atspec=${atspec} \
      ts_idl=${idl} \
      ts_config_latiss=${config}

COPY setup.sh /home/saluser/.setup.sh
