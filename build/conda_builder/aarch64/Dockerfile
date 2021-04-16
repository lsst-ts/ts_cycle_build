FROM centos:centos7

ARG UID=1003
ARG GID=1003

LABEL maintainer="Wouter van Reeven <wvanreeven@lsst.org>"

ENV USER=${USER:-saluser}
ENV HOME=/home/saluser

ENV PYTHON_BUILD_LOCATION=/home/saluser/miniconda3

USER root

# Create user and group
RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -G wheel,dialout -s /bin/bash saluser

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY conda_builder/aarch64/setup.sh /home/saluser/.setup.sh
COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh

ARG dds_community_version=6.9.0

RUN chown saluser:saluser /home/saluser/.setup.sh && \
    chown saluser:saluser /home/saluser/.checkout_repo.sh && \
    chmod a+x /home/saluser/.setup.sh && \
    chmod a+x /home/saluser/.checkout_repo.sh && \
    touch ${HOME}/.ospl_env.sh && \
    chown saluser:saluser ${HOME}/.ospl_env.sh && \
    chmod a+x ${HOME}/.ospl_env.sh && \
    yum install -y git make gcc-c++ && \
    yum install -y OpenSpliceDDS && \
    echo export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/aarch64.linux >> ${SALUSER_HOME}/.ospl.env

USER saluser

WORKDIR /home/saluser

ENV OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/aarch64.linux

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -o miniforge.sh && \
    chmod +x miniforge.sh && ./miniforge.sh -b -p ${PYTHON_BUILD_LOCATION} && \
    source ~/miniconda3/bin/activate && \
    conda config --add channels lsstts && \
    conda install -y numpy=1.20 && \
    conda install -y conda-build anaconda-client setuptools_scm ts-ddsconfig && \
    conda init bash

ENTRYPOINT ["/bin/bash", "--"]

CMD ["/home/saluser/.setup.sh"]
