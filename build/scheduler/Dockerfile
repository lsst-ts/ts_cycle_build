ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

WORKDIR /home/saluser/

ARG config

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

WORKDIR /home/saluser/ts_config_ocs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs

ARG ts_scheduler
ARG ts_observatory_model
ARG ts_astrosky_model
ARG ts_dateloc
ARG rubin_sim

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts \
    ts-scheduler=${ts_scheduler} \
    ts-observatory-model=${ts_observatory_model} \
    ts-astrosky-model=${ts_astrosky_model} \
    ts-dateloc=${ts_dateloc} \
    rubin-sim=${rubin_sim}

LABEL ts-scheduler=${ts_scheduler} \
  ts-scheduler=${ts_scheduler} \
  ts-observatory-model=${ts_observatory_model} \
  ts-astrosky-model=${ts_astrosky_model} \
  ts-dateloc=${ts_dateloc} \
  rubin-sim=${rubin_sim} \
  ts_config_ocs=${config}


WORKDIR /home/saluser/

ENV INDEX=1

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
