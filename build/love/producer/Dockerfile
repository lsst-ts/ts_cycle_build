ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG love_producer

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts love-producer=${love_producer} && \
    python -m pip install kafkit[aiohttp] aiokafka

LABEL love_producer=${love_producer}

COPY startup.sh /home/saluser/.startup.sh

USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER saluser
