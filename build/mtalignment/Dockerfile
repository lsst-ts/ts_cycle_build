ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG ts_mtalignment

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -y -c lsstts ts-mtalignment=${ts_mtalignment}

RUN git clone https://github.com/lsst-ts/ts_config_mttcs.git

WORKDIR /home/saluser/ts_config_mttcs

ARG config
RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_MTTCS_DIR=/home/saluser/ts_config_mttcs
ENV RUN_ARG=""

LABEL ts-mtalignment=${ts_mtalignment} \
    ts_config_mttcs=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
