ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

WORKDIR /home/saluser/
RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

ARG config_ocs
WORKDIR /home/saluser/ts_config_ocs
RUN /home/saluser/.checkout_repo.sh ${config_ocs}

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV RUN_ARG=1

WORKDIR /home/saluser/

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org> \
      ts_config_ocs ${config_ocs}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
RUN dnf install -y iperf3
USER saluser
