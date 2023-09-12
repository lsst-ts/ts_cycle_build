ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG love_commander
ARG ts_observatory_control
# We are pinning ts-criopy to 0.7.0 because the love-commander is complaining for some missing
# libGL libraries when using pyside6 that comes with ts-criopy 0.8.0
ARG ts_criopy=0.7.0

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts -c lsstts/label/rc love-commander=${love_commander} ts-observatory-control=${ts_observatory_control} && \
    pip install kafkit[aiohttp] aiokafka lsst_efd_client

LABEL love_commander=${love_commander}

COPY startup.sh /home/saluser/.startup.sh

USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

RUN dnf install -y \
    libglvnd-glx \
    libglvnd-opengl

USER saluser
