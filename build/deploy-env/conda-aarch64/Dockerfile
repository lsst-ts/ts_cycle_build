FROM centos:centos7

ARG UID=73006
ARG GID=73006

LABEL maintainer="Wouter van Reeven <wvanreeven@lsst.org>"

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
ENV WORKDIR /opt/lsst/software/stack
ENV LSST_DDS_DOMAIN=citest

USER root

RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY deploy-env/conda-aarch64/startup.sh /home/saluser/.startup.sh
COPY deploy-env/conda-aarch64/setup_sal_env.sh /home/saluser/.setup_sal_env.sh
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

USER saluser

WORKDIR ${WORKDIR}

ARG numpy=1.20
ARG ts_idl
ARG ts_salobj

ENV OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/aarch64.linux

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -o miniforge.sh && \
    chmod +x miniforge.sh && ./miniforge.sh -b -p ${WORKDIR}/miniforge && \
    source /home/saluser/.setup_sal_env.sh && \
    conda config --add channels conda-forge && \
    conda install -y cython && \
    conda install -y -c lsstts -c lsstts/label/dev python=3.8 && \
    conda install -y -c lsstts numpy=${numpy} && \
    conda install -y -c lsstts ts-dds && \
    conda install -y -c lsstts ts-idl=${ts_idl} && \
    conda install -y -c lsstts ts-salobj=${ts_salobj} && \
    echo export LSST_DDS_QOS=file://$(python -c "from lsst.ts import ddsconfig; print(ddsconfig.get_qos_path())") >> ${HOME}/.ospl_env.sh

WORKDIR /home/saluser/

ENV OSPL_MASTER_PRIORITY=5

LABEL dds_community_version=${dds_community_version} \
      dds_community_build=${dds_community_build} \
      dds_private_version=${dds_private_version} \
      dds_private_build=${dds_private_version} \
      ts_salobj=${ts_salobj} \
      ts_dds=${ts_dds} \
      ts_idl=${ts_idl}

ENTRYPOINT ["/home/saluser/.startup.sh"]
