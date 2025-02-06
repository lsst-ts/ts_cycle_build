FROM almalinux:8

ARG UID=73006
ARG GID=73006

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

ENV PYTHON_BUILD_LOCATION=/home/saluser/miniconda3

USER root

# Create user and group
RUN dnf install -y mlocate
RUN groupadd --gid ${GID} saluser && \
  adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash
RUN dnf install -y gcc-c++ \
  make \
  ncurses-libs \
  xterm \
  xorg-x11-fonts-misc \
  java-1.8.0-openjdk-devel \
  maven \
  git \
  git-lfs \
  bzip2 \
  wget \
  libusb \
  libglvnd-glx \
  unzip \
  epel-release \
  freeglut-devel \
  mesa-dri-drivers \
  xorg-x11-server-Xvfb

COPY conda_builder/linux64/setup.sh /home/saluser/.setup.sh
COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh
COPY common/conda_build_config.yaml /home/saluser/conda_build_config.yaml

USER saluser
WORKDIR /home/saluser

ARG PYTHON_VERSION=3.11

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -o miniforge.sh && \
  chmod +x miniforge.sh && \
  ./miniforge.sh -b -p ${HOME}/miniconda3 && \
  source ${HOME}/miniconda3/bin/activate && \
  conda config --set solver libmamba && \
  conda install -y python=${PYTHON_VERSION} && \
  conda config --add channels conda-forge && \
  conda config --add channels lsstts && \
  conda install -y Cython && \
  conda install -y conda-build anaconda-client setuptools_scm ts-ddsconfig && \
  conda init bash

USER saluser
WORKDIR /home/saluser

ENTRYPOINT ["/bin/bash", "--"]

CMD ["/home/saluser/.setup.sh"]
