ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Michael Reuter <mareuter@lsst.org>

ARG dsm

RUN mkdir /home/saluser/telemetry

WORKDIR /home/saluser

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-dsm=${dsm}

ENV CSC_INDEX=1
ENV RUN_ARG=""

LABEL ts-dsm=${dsm}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
COPY shutdown.sh /home/saluser/shutdown.sh
RUN chown saluser:saluser /home/saluser/shutdown.sh && \
    chmod a+x /home/saluser/shutdown.sh
USER saluser
