ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG athexapod
ARG config

RUN git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/saluser/ts_config_attcs

RUN /home/saluser/.checkout_repo.sh ${config}

ENV TS_CONFIG_ATTCS_DIR=/home/saluser/ts_config_attcs
ENV RUN_ARG=""

WORKDIR /home/saluser/

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -c lsstts ts-athexapod=${athexapod}

LABEL ts-athexapod=${athexapod} \
      ts_config_attcs=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
