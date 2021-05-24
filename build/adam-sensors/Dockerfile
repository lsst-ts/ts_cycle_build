ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG ts_adamSensors
ARG config

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-adamsensors=${ts_adamSensors}

RUN git clone https://github.com/lsst-ts/ts_config_eas.git

WORKDIR /home/saluser/ts_config_eas

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_EAS_DIR=/home/saluser/ts_config_eas
ENV RUN_ARG=""

LABEL ts-adamsensors=${ts_adamSensors} \
      ts_config_eas=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
