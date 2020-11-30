ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG rotator=0.1.dev51+gad1edcb
ARG hexrotcomm=0.5.0

RUN git clone https://github.com/lsst-ts/ts_config_mttcs.git

WORKDIR /home/saluser/ts_config_mttcs

ARG config

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_MTTCS_DIR=/home/saluser/ts_config_mttcs

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-rotator=${rotator} ts-hexrotcomm=${hexrotcomm}

LABEL rotator=${rotator} \
      hexrotcomm=${hexrotcomm} \
      ts_config_mttcs=${config}

ENV RUN_ARG=""
COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
