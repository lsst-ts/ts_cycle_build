FROM almalinux:8

ARG UID=1003
ARG GID=1003

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

ENV PYTHON_BUILD_LOCATION=${HOME}/miniconda3

USER root

RUN dnf install -y mlocate
RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash
RUN dnf install -y gcc-c++ make ncurses-libs xterm xorg-x11-fonts-misc java-1.8.0-openjdk-devel maven git git-lfs bzip2

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY conda_builder/aarch64/setup.sh ${HOME}/.setup.sh
COPY develop-env/salobj/checkout_repo.sh ${HOME}/.checkout_repo.sh
COPY conda_builder/linux64/conda_build_config.yaml /home/saluser/conda_build_config.yaml

RUN chown saluser:saluser ${HOME}/.setup.sh && \
    chown saluser:saluser ${HOME}/.checkout_repo.sh && \
    chown saluser:saluser /home/saluser/conda_build_config.yaml && \
    chmod a+x ${HOME}/.setup.sh && \
    chmod a+x ${HOME}/.checkout_repo.sh

USER saluser

WORKDIR ${HOME}

ARG PYTHON_VERSION=3.10

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-aarch64.sh -o mambaforge.sh && \
    chmod +x mambaforge.sh && \
    ./mambaforge.sh -b -p ${HOME}/miniconda3 && \
    source ${HOME}/miniconda3/bin/activate && \
    mamba install -y python=${PYTHON_VERSION} && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    mamba update -y --all && \
    mamba install -y conda-build anaconda-client setuptools_scm ts-ddsconfig boa && \
    mamba init bash

ENTRYPOINT ["/bin/bash", "--"]

CMD ["/home/saluser/.setup.sh"]
