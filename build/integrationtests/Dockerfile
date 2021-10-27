ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Rob Bovill <rbovill@lsst.org>

ARG integrationtests

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts -y ts-integrationtests=${integrationtests}

WORKDIR /home/saluser/

ENV RUN_ARG="simple_script.py"

LABEL integrationtests=${integrationtests}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
