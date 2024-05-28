ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG mtmount
ARG tcpip
ARG config

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts ts-mtmount=${mtmount} ts-tcpip=${tcpip}

RUN git clone https://github.com/lsst-ts/ts_config_mttcs.git

WORKDIR /home/saluser/ts_config_mttcs
RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_MTTCS_DIR=/home/saluser/ts_config_mttcs
ENV RUN_ARG=""

LABEL mtmount=${mtmount} \
      tcpip=${tcpip} \
      config=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
