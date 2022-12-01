ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ARG weatherforecast

WORKDIR /home/saluser/

ENV RUN_ARG=""

COPY startup.sh /home/saluser/.startup.sh

USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-weatherforecast=${weatherforecast}

USER saluser

LABEL ts-weatherforecast=${weatherforecast}
