ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

WORKDIR /home/saluser/

ARG config

RUN git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/saluser/ts_config_attcs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_ATTCS_DIR=/home/saluser/ts_config_attcs

ARG ts_observatory_control
ARG ts_ataos

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts -c lsstts/label/rc \
    ts-ataos=${ts_ataos} \
    ts-observatory-control=${ts_observatory_control}

LABEL ts_observatory_control=${ts_observatory_control} \
      ts_config_attcs=${config} \
      ts_ataos=${ataos}

WORKDIR /home/saluser/

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
