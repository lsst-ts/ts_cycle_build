FROM centos:7

ARG UID=1003
ARG GID=1003

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

ENV PYTHON_BUILD_LOCATION=/home/saluser/miniconda3

USER root

RUN yum install -y mlocate
RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash
RUN yum install -y gcc-c++ make ncurses-libs xterm xorg-x11-fonts-misc java-1.7.0-openjdk-devel maven git git-lfs bzip2

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-nexus-private.repo
COPY conda_builder/linux64/setup.sh /home/saluser/.setup.sh
COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh

# Create user and group

ARG dds_community_version=6.9.0
ARG dds_community_build=1.el6
ARG dds_private_version
ARG dds_private_build

RUN chown saluser:saluser /home/saluser/.setup.sh && \
    chown saluser:saluser /home/saluser/.checkout_repo.sh && \
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

ARG PYTHON_VERSION=3.8m
ARG CONDA_PY_VERSION=38
ARG CONDA_VERSION=4.11.0

RUN curl https://repo.anaconda.com/miniconda/Miniconda3-py${CONDA_PY_VERSION}_${CONDA_VERSION}-Linux-x86_64.sh -o miniconda.sh && chmod +x miniconda.sh && ./miniconda.sh -b

RUN source ~/miniconda3/bin/activate && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    conda install -y conda-build anaconda-client setuptools_scm ts-ddsconfig && \
    conda init bash

COPY conda_builder/linux64/setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]

CMD ["/home/saluser/.setup.sh"]
