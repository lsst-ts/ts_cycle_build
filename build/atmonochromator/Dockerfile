ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atmonochromator
ARG config

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -c lsstts ts-atmonochromator=${atmonochromator}

RUN git clone https://github.com/lsst-ts/ts_config_atcalsys.git

WORKDIR /home/saluser/ts_config_atcalsys

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_ATCALSYS_DIR=/home/saluser/ts_config_atcalsys
ENV RUN_ARG=""

LABEL ts-atmonochromator=${atmonochromator} \
    ts_config_atcalsys=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
