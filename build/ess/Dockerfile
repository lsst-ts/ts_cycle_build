ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ARG ess
ARG common
ARG config

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

# Install labjack
USER root
WORKDIR /tmp
ARG labjack_file_version
ARG labjack_arch
ARG ljm_version
COPY common/install_labjack.sh /tmp/install_labjack.sh
RUN chmod +x /tmp/install_labjack.sh && \
    /tmp/install_labjack.sh --labjack_file_version=${labjack_file_version} \
        --labjack_arch=${labjack_arch} --ljm_version=${ljm_version} \
        --saluser_env_script="/opt/lsst/software/stack/miniconda/bin/activate"

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-ess-common=${common} ts-ess-csc=${ess}

USER saluser

LABEL ts-ess-csc=${ess} \
      ts-ess-common=${common} \
      ts_config_ocs=${config}
