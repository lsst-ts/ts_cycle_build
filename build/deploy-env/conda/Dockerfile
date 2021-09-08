FROM centos:7

ARG UID=73006
ARG GID=73006

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
ENV WORKDIR /opt/lsst/software/stack

USER root

RUN groupadd --gid ${GID} saluser && \
  adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-nexus-private.repo
COPY deploy-env/conda/startup.sh /home/saluser/.startup.sh
COPY deploy-env/conda/setup_sal_env.sh /home/saluser/.setup_sal_env.sh
COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh

# Create user and group

ARG dds_community_version=6.9.0
ARG dds_community_build=1.el6
ARG dds_private_version
ARG dds_private_build

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

WORKDIR ${WORKDIR}

ARG ts_dds
ARG ts_ddsconfig
ARG ts_idl
ARG ts_utils
ARG ts_salobj

RUN curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh && \
  chmod +x miniconda.sh && ./miniconda.sh -b -p ${WORKDIR}/miniconda && \
  source /home/saluser/.setup_sal_env.sh && \
  conda config --add channels conda-forge && \
  conda install -y cython && \
  conda install -y -c lsstts -c lsstts/label/dev python=3.8 ts-ddsconfig=${ts_ddsconfig} ts-salobj=${ts_salobj} ts-dds=${ts_dds} ts-idl=${ts_idl} ts-utils=${ts_utils} && \
  echo export LSST_DDS_QOS=file://$(python -c "from lsst.ts import ddsconfig; print(ddsconfig.get_qos_path())") >> ${HOME}/.ospl_env.sh

WORKDIR /home/saluser/

ENV OSPL_MASTER_PRIORITY=5

LABEL dds_community_version=${dds_community_version} \
  dds_community_build=${dds_community_build} \
  dds_private_version=${dds_private_version} \
  dds_private_build=${dds_private_version} \
  ts_dds=${ts_dds} \
  ts_idl=${ts_idl} \
  ts_ddsconfig=${ts_ddsconfig} \
  ts_utils=${ts_utils} \
  ts_salobj=${ts_salobj}

ENTRYPOINT ["/home/saluser/.startup.sh"]
