FROM centos:centos7

ARG UID=73006
ARG GID=73006

LABEL maintainer="Wouter van Reeven <wvanreeven@lsst.org>"

ENV USER=${USER:-saluser}
ENV HOME=/home/saluser
ENV WORKDIR=/opt/lsst/software/stack
ENV LSST_DDS_DOMAIN=citest

USER root

RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -G wheel,dialout -s /bin/bash saluser

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY conda_builder/aarch64/startup.sh /home/saluser/.startup.sh
COPY conda_builder/aarch64/setup_sal_env.sh /home/saluser/.setup_sal_env.sh
COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh

# Create user and group

ARG dds_community_version=6.9.0

RUN mkdir -p ${WORKDIR} && \
    chmod -R a+rw ${WORKDIR}/../ && \
    chown -R saluser:saluser /opt/lsst/ && \
    chown saluser:saluser /home/saluser/.startup.sh && \
    chown saluser:saluser /home/saluser/.setup_sal_env.sh && \
    chown saluser:saluser /home/saluser/.checkout_repo.sh && \
    chmod a+x /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.setup_sal_env.sh && \
    chmod a+x /home/saluser/.checkout_repo.sh && \
    touch ${HOME}/.ospl_env.sh && \
    chown -R saluser:saluser ${HOME}/.ospl_env.sh && \
    chmod a+x ${HOME}/.ospl_env.sh && \
    yum install -y git make gcc-c++ && \
    yum install -y OpenSpliceDDS ;\
    echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/aarch64.linux" >> ${SALUSER_HOME}/.ospl.env \

WORKDIR ${WORKDIR}

ENV OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/aarch64.linux

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -o miniforge.sh && \
    chmod +x miniforge.sh && ./miniforge.sh -b -p ${WORKDIR}/miniforge && \
    source /home/saluser/.setup_sal_env.sh && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    conda install -y cython && \
    conda install -y python=3.8 && \
    conda install -y conda-build anaconda-client setuptools_scm

WORKDIR /home/saluser/

ENV OSPL_MASTER_PRIORITY=5
