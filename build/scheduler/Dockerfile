ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

WORKDIR /home/saluser/

ARG ts_observatory_model
ARG ts_astrosky_model
ARG ts_dateloc
ARG rubin_sim
ARG ts_fbs_utils

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts \
    ts-observatory-model=${ts_observatory_model} \
    ts-astrosky-model=${ts_astrosky_model} \
    ts-dateloc=${ts_dateloc} \
    rubin-sim=${rubin_sim} \
    ts-fbs-utils=${ts_fbs_utils}

ARG ts_scheduler

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts \
    ts-scheduler=${ts_scheduler}

RUN source /home/saluser/.setup_sal_env.sh && \
    pip install lsst-efd-client

ARG config

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

WORKDIR /home/saluser/ts_config_ocs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs

LABEL ts-scheduler=${ts_scheduler} \
    ts-scheduler=${ts_scheduler} \
    ts-observatory-model=${ts_observatory_model} \
    ts-astrosky-model=${ts_astrosky_model} \
    ts-dateloc=${ts_dateloc} \
    ts-fbs-utils=${ts_fbs_utils} \
    rubin-sim=${rubin_sim} \
    ts_config_ocs=${config}


WORKDIR /home/saluser/

ENV INDEX=1

ENV SIMS_SKYBRIGHTNESS_DATA=/home/saluser/rubin_sim_data/skybrightness_pre_full

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
