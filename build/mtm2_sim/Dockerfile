ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

ARG m2=0.1.dev9+geb50cc5
ARG config=v0.2.0

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-m2=${m2}

WORKDIR /home/saluser/

RUN git clone https://github.com/lsst-ts/ts_config_mttcs.git

WORKDIR /home/saluser/ts_config_mttcs

RUN git checkout ${config} -b ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_MTTCS_DIR=/home/saluser/ts_config_mttcs

LABEL ts_m2=${m2} \
      ts_config_mttcs=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
