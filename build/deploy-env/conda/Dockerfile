FROM almalinux:8

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

ARG dds_community_version
ARG dds_community_build
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
  dnf install -y git make gcc-c++ procps-ng which && \
  if [ -z "${dds_private_version}" ]; then \
      dnf install -y OpenSpliceDDS-${dds_community_version}-${dds_community_build} || exit  ; \
      echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/x86_64.linux" >> ${HOME}/.ospl_env.sh ; \
  else \
      dnf install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
      OpenSpliceDDS-${dds_private_version}-${dds_private_build} || exit  ; \
      echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_private_version}/HDE/x86_64.linux" >> ${HOME}/.ospl_env.sh ; \
  fi; \
  (rm /etc/yum.repos.d/lsst-ts-nexus-private.repo || echo "No Private repo")

# Make sure that saluser can use the ping command
RUN if [ -f "/bin/ping" ]; then \
    setcap cap_net_raw+ep /bin/ping; \
  fi

USER saluser

WORKDIR ${WORKDIR}

ARG ts_dds
ARG ts_ddsconfig
ARG ts_idl
ARG ts_utils
ARG ts_salobj

ARG PYTHON_VERSION

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -o mambaforge.sh && \
  chmod +x mambaforge.sh && \
  ./mambaforge.sh -b -p ${WORKDIR}/miniconda && \
  source /home/saluser/.setup_sal_env.sh && \
  mamba install -y python=${PYTHON_VERSION} && \
  conda config --add channels conda-forge && \
  conda config --add channels lsstts && \
  mamba update -y --all && \
  mamba install -y cython && \
  mamba install -y -c lsstts -c lsstts/label/dev ts-xml=${ts_xml} ts-ddsconfig=${ts_ddsconfig} ts-salobj=${ts_salobj} ts-dds=${ts_dds} ts-idl=${ts_idl} ts-utils=${ts_utils} && \
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
