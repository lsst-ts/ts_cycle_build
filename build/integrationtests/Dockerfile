ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}
LABEL maintainer Rob Bovill <rbovill@lsst.org>

WORKDIR ${HOME}

ARG integrationtests

RUN source /home/saluser/.setup_sal_env.sh && \
mamba install -c lsstts ts-integrationtests=${integrationtests} -y && \
mamba install -c conda-forge robotframework && \
pip3 install -U lsst-efd-client

RUN git clone https://github.com/lsst-ts/robotframework_EFD.git

ENV RUN_ARG="echo 'Do something here'"

LABEL integrationtests=${integrationtests}

USER root
COPY startup.sh /home/saluser/.startup.sh
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER ${USER}
