ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG love_commander
ARG ts_observatory_control
ARG ts_criopy

USER root
RUN dnf install -y libglvnd-glx
USER saluser

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts love-commander=${love_commander} ts-observatory-control=${ts_observatory_control} ts-criopy=${ts_criopy} && \
    pip install kafkit[aiohttp] aiokafka lsst_efd_client

LABEL love_commander=${love_commander}

COPY startup.sh /home/saluser/.startup.sh

USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER saluser
