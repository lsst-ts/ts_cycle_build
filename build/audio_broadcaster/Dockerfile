ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Eric Coughlin <ecoughlin@lsst.org>

WORKDIR /home/saluser/

ARG ts_audio_broadcaster

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -c lsstts \
    ts-audio-broadcaster=${ts_audio_broadcaster}

LABEL ts_audio_broadcaster=${ts_audio_broadcaster}

COPY startup.sh /home/saluser/.startup.sh 
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
