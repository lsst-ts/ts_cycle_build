ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}
MAINTAINER Rob Bovill <rbovill@lsst.org>

ARG USER=saluser
ARG HOME=/home/${USER}
ENV PYTHONPATH="$PYTHONPATH:/usr/local/lib/python3.8/site-packages/lsst_efd_client"
ENV PATH $PATH:${HOME}/bin:${HOME}/.local/bin
ENV LSST_DDS_PARTITION_PREFIX tucson

WORKDIR ${HOME}

RUN mkdir Reports repos

RUN source ${HOME}/.setup_sal_env.sh && \
conda update conda -y && \
mamba install -c lsstts ts-integrationtests -y && \
mamba install -c conda-forge robotframework && \
pip3 install -U lsst-efd-client

WORKDIR ${HOME}/repos
RUN git clone https://github.com/lsst-ts/robotframework_EFD.git

WORKDIR ${HOME}/repos/robotframework_EFD
RUN ${HOME}/.checkout_repo.sh main develop

USER ${USER}
WORKDIR ${HOME}
