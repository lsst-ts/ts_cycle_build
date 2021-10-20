ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

WORKDIR /home/saluser/
RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV RUN_ARG=1

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
