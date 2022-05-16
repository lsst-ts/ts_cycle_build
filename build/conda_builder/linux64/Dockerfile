FROM centos:7

ARG UID=1003
ARG GID=1003

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

ENV PYTHON_BUILD_LOCATION=/home/saluser/miniconda3

USER root

RUN yum install -y mlocate

# Create user and group
RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash
RUN yum install -y gcc-c++ make ncurses-libs xterm xorg-x11-fonts-misc java-1.7.0-openjdk-devel maven git git-lfs bzip2

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-nexus-private.repo
COPY conda_builder/linux64/setup.sh /home/saluser/.setup.sh
COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh
COPY conda_builder/linux64/conda_build_config.yaml /home/saluser/conda_build_config.yaml

ARG dds_community_version=6.9.0
ARG dds_community_build=1.el6
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
    yum install -y git make gcc-c++ && \
    if [ -z "${dds_private_version}" ]; then \
      yum install -y OpenSpliceDDS-${dds_community_version}-${dds_community_build} ; \
      echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/x86_64.linux" >> ${HOME}/.ospl_env.sh ; \
    else \
      yum install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
      OpenSpliceDDS-${dds_private_version}-${dds_private_build} ; \
      echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_private_version}/HDE/x86_64.linux" >> ${HOME}/.ospl_env.sh ; \
    fi; \
    rm /etc/yum.repos.d/lsst-ts-nexus-private.repo

USER saluser
WORKDIR /home/saluser

ARG PYTHON_VERSION=3.8

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -o mambaforge.sh && \
    chmod +x mambaforge.sh && \
    ./mambaforge.sh -b -p ${HOME}/miniconda3 && \
    source ${HOME}/miniconda3/bin/activate && \
    mamba install -y python=${PYTHON_VERSION} && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    mamba update -y --all && \
    mamba install -y conda-build anaconda-client setuptools_scm ts-ddsconfig boa && \
    mamba init bash

COPY conda_builder/linux64/setup.sh /home/saluser/.setup.sh

# Install labjack
USER root
WORKDIR /tmp
ARG labjack_file_version
ARG labjack_arch
ARG ljm_version
COPY common/install_labjack.sh /tmp/install_labjack.sh
RUN chmod +x /tmp/install_labjack.sh && \
    /tmp/install_labjack.sh --labjack_file_version=${labjack_file_version} \
        --labjack_arch=${labjack_arch} --ljm_version=${ljm_version} \
        --saluser_env_script="/home/saluser/miniconda3/bin/activate"

USER saluser
WORKDIR /home/saluser

ENTRYPOINT ["/bin/bash", "--"]

CMD ["/home/saluser/.setup.sh"]
