ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ARG ess
ARG common
ARG config
ARG earthquake
ARG epm
ARG labjack
ARG labjack_ljm
ARG ringss

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

WORKDIR /home/saluser/ts_config_ocs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV RUN_ARG=""

COPY ess/startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts "$(conda_package_spec ts-ess-common "${common}")" "$(conda_package_spec ts-ess-earthquake "${earthquake}")" "$(conda_package_spec ts-ess-epm "${epm}")" \
        "$(conda_package_spec ts-ess-labjack "${labjack}")" "$(conda_package_spec ts-ess-csc "${ess}")" "$(conda_package_spec ts-ess-ringss "${ringss}")" labjack-ljm=${labjack_ljm}

USER saluser

LABEL ts-ess-csc=${ess} \
      ts-ess-common=${common} \
      ts-ess-earthquake=${earthquake} \
      ts-ess-epm=${epm} \
      ts-ess-labjack=${labjack} \
      ts-ess-ringss=${ringss} \
      ts_config_ocs=${config} \
      labjack-ljm=${labjack_ljm}
