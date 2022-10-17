ARG cycle
ARG hub

FROM ${hub}/genericcamera:${cycle}

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ARG gphoto2

USER saluser

RUN source /home/saluser/.setup_sal_env.sh && \
    pip install gphoto2==${gphoto2} --only-binary :all: && \
    pip install rawpy

LABEL gphoto2=${gphoto2}
