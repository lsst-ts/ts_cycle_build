ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}
LABEL maintainer Rob Bovill <rbovill@lsst.org>

WORKDIR ${HOME}

ARG integrationtests

RUN source /home/saluser/.setup_sal_env.sh && \
conda install -y -c lsstts ts-integrationtests=${integrationtests} -y && \
conda install -y -c conda-forge robotframework PyYAML aioinflux pandas astropy pytables kafkit && \
pip3 install --no-deps -U lsst-efd-client

RUN git clone https://github.com/lsst-ts/robotframework_EFD.git

WORKDIR /home/saluser/robotframework_EFD

ARG robot_efd

RUN /home/saluser/.checkout_repo.sh ${robot_efd}

ENV PYTHONPATH "$PYTHONPATH:/home/saluser/robotframework_EFD"
ENV RUN_ARG=""

LABEL integrationtests=${integrationtests}

USER root
COPY startup.sh /home/saluser/.startup.sh
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER ${USER}
