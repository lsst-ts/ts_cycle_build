ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG dmocps
ARG config

RUN git clone https://github.com/lsst/dm_config_ocps.git

WORKDIR /home/saluser/dm_config_ocps

RUN /home/saluser/.checkout_repo.sh ${config}

ENV DM_CONFIG_OCPS_DIR=/home/saluser/dm_config_ocps
ENV RUN_ARG=""

WORKDIR /home/saluser/

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsst-dm -c lsstts dm-ocps=${dmocps}

LABEL dm_ocps=${dmocps} \
      dm_config_ocps=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
