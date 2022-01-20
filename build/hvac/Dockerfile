ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ARG hvac
ARG config

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

WORKDIR /home/saluser/ts_config_ocs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV RUN_ARG=""

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-hvac=${hvac}

LABEL ts-hvac=${hvac} \
      ts_config_ocs=${config}
