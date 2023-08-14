ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atdome
ARG config

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -c lsstts ts-atdome=${atdome}

RUN git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/saluser/ts_config_attcs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_ATTCS_DIR=/home/saluser/ts_config_attcs
ENV RUN_ARG=""

LABEL ts-atdome=${atdome} \
      ts_config_attcs=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
