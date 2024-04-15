ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Eric Coughlin <ecoughlin@lsst.org>

ARG tunablelaser
ARG config

RUN git clone https://github.com/lsst-ts/ts_config_mtcalsys.git

WORKDIR /home/saluser/ts_config_mtcalsys

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_MTCALSYS_DIR=/home/saluser/ts_config_mtcalsys
ENV RUN_ARG=""

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -c lsstts ts-tunablelaser=${tunablelaser}

USER saluser

LABEL ts-tunablelaser=${tunablelaser} \
      ts_config_mtcalsys=${config}