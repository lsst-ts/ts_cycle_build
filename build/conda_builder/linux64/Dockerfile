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
  qt5-qtbase-devel \
  mesa-dri-drivers \
  xorg-x11-server-Xvfb

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-nexus-private.repo
COPY conda_builder/linux64/setup.sh /home/saluser/.setup.sh
COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh
COPY common/conda_build_config.yaml /home/saluser/conda_build_config.yaml

ARG dds_community_version=6.9.0
ARG dds_community_build=2.el8
ARG dds_private_version
ARG dds_private_build

RUN chown saluser:saluser /home/saluser/.setup.sh && \
  chown saluser:saluser /home/saluser/.checkout_repo.sh && \
  chown saluser:saluser /home/saluser/conda_build_config.yaml && \
  chmod a+x /home/saluser/.setup.sh && \
  chmod a+x /home/saluser/.checkout_repo.sh && \
  touch ${HOME}/.ospl_env.sh && \
  chown -R saluser:saluser ${HOME}/.ospl_env.sh && \
  chmod a+x ${HOME}/.ospl_env.sh && \
  dnf install -y git make gcc-c++ && \
  if [ -z "${dds_private_version}" ]; then \
  dnf install -y OpenSpliceDDS-${dds_community_version}-${dds_community_build} ; \
  echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/x86_64.linux" >> ${HOME}/.ospl_env.sh ; \
  else \
  dnf install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts OpenSpliceDDS-${dds_private_version}-${dds_private_build} ; \
  echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_private_version}/HDE/x86_64.linux" >> ${HOME}/.ospl_env.sh ; \
  fi; \
  rm /etc/yum.repos.d/lsst-ts-nexus-private.repo

USER saluser
WORKDIR /home/saluser

ARG PYTHON_VERSION=3.10

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -o mambaforge.sh && \
  chmod +x mambaforge.sh && \
  ./mambaforge.sh -b -p ${HOME}/miniconda3 && \
  source ${HOME}/miniconda3/bin/activate && \
  mamba install -y python=${PYTHON_VERSION} && \
  conda config --add channels conda-forge && \
  conda config --add channels lsstts && \
  mamba update -y --all && \
  mamba install -y Cython && \
  mamba install -y conda-build anaconda-client setuptools_scm ts-ddsconfig boa && \
  mamba init bash

USER saluser
WORKDIR /home/saluser

ENTRYPOINT ["/bin/bash", "--"]

CMD ["/home/saluser/.setup.sh"]
