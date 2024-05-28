ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Eric Coughlin <ecoughlin@lsst.org>

ARG electrometer
ARG utils
ARG config

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts ts-electrometer=${electrometer} ts-utils=${utils}

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

WORKDIR /home/saluser/ts_config_ocs
RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV RUN_ARG=""

LABEL electrometer=${electrometer} \
    config=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
