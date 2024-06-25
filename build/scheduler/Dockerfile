ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

WORKDIR /home/saluser/

ARG ts_observatory_model
ARG ts_astrosky_model
ARG ts_dateloc
ARG rubin_scheduler
ARG ts_fbs_utils
ARG ts_scheduler
ARG ts_observing

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts \
    scipy=1.13 \
    ts-observatory-model=${ts_observatory_model} \
    ts-astrosky-model=${ts_astrosky_model} \
    ts-dateloc=${ts_dateloc} \
    ts-observing=${ts_observing} \
    rubin-scheduler=${rubin_scheduler} \
    ts-scheduler=${ts_scheduler}  \
    ts-fbs-utils=${ts_fbs_utils}

ARG lsst_efd_client

RUN source /home/saluser/.setup_sal_env.sh && \
    pip install lsst-efd-client==${lsst_efd_client}

ARG config

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

WORKDIR /home/saluser/ts_config_ocs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV SIMS_SKYBRIGHTNESS_DATA=/home/saluser/rubin_sim_data/skybrightness_pre_full

LABEL ts-scheduler=${ts_scheduler} \
    ts-scheduler=${ts_scheduler} \
    ts-observatory-model=${ts_observatory_model} \
    ts-astrosky-model=${ts_astrosky_model} \
    ts-dateloc=${ts_dateloc} \
    ts-fbs-utils=${ts_fbs_utils} \
    rubin-scheduler=${rubin_scheduler} \
    lsst_efd_client=${lsst_efd_client} \
    ts_observing=${ts_observing} \
    ts_config_ocs=${config}


WORKDIR /home/saluser/

ENV INDEX=1

ENV schedulerS_SKYBRIGHTNESS_DATA=/home/saluser/rubin_scheduler_data/skybrightness_pre_full

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
