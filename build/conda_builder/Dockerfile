ARG platform=linux/aarch64
FROM --platform=${platform} almalinux:9

ARG UID=73006
ARG GID=73006

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

ENV PYTHON_BUILD_LOCATION=${HOME}/miniconda3

USER root

RUN dnf install -y mlocate
RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash
RUN dnf install -y gcc-c++ make ncurses-libs xterm xorg-x11-fonts-misc java-1.8.0-openjdk-devel maven git \
    git-lfs bzip2 wget libusb libglvnd-glx unzip

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY conda_builder/setup.sh ${HOME}/.setup.sh
COPY develop-env/salobj/checkout_repo.sh ${HOME}/.checkout_repo.sh
COPY common/conda_build_config.yaml /home/saluser/conda_build_config.yaml

RUN chown saluser:saluser /home/saluser/.setup.sh && \
    chown saluser:saluser /home/saluser/.checkout_repo.sh && \
    chown saluser:saluser /home/saluser/conda_build_config.yaml && \
    chmod a+x /home/saluser/.setup.sh && \
    chmod a+x /home/saluser/.checkout_repo.sh

RUN if [ -d "$HOME/.cache" ]; then \
    chown -R saluser:saluser "$HOME/.cache"; \
    fi

USER saluser
WORKDIR /home/saluser

ARG PYTHON_VERSION=3.12

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$(uname -m).sh -o miniforge.sh && \
    chmod +x miniforge.sh && \
    ./miniforge.sh -b -p ${HOME}/miniconda3 && \
    source ${HOME}/miniconda3/bin/activate && \
    conda config --set solver libmamba && \
    conda install -y python=${PYTHON_VERSION} && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    conda install -y conda-build anaconda-client setuptools_scm && \
    conda init bash

ENTRYPOINT ["/bin/bash", "--"]

CMD ["/home/saluser/.setup.sh"]
