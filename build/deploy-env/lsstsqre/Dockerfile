FROM almalinux:8

ARG UID=73006
ARG GID=73006

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
ENV WORKDIR /opt/lsst/software/stack

USER root

RUN dnf install -y mesa-libEGL

RUN groupadd --gid ${GID} saluser && \
  adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-nexus-private.repo
COPY deploy-env/lsstsqre/startup.sh ${HOME}/.startup.sh
COPY deploy-env/lsstsqre/setup_sal_env.sh ${HOME}/.setup_sal_env.sh
COPY develop-env/salobj/checkout_repo.sh ${HOME}/.checkout_repo.sh

# Create user and group

ARG dds_community_version=6.9.0
ARG dds_community_build=1.el6
ARG dds_private_version
ARG dds_private_build

RUN chown ${UID}:${GID} ${HOME}/.startup.sh && \
  chown ${UID}:${GID} ${HOME}/.setup_sal_env.sh && \
  chown ${UID}:${GID} ${HOME}/.checkout_repo.sh && \
  chmod a+x ${HOME}/.startup.sh && \
  chmod a+x ${HOME}/.setup_sal_env.sh && \
  chmod a+x ${HOME}/.checkout_repo.sh && \
  mkdir -p ${WORKDIR} && \
  touch ${WORKDIR}/ospl_env.sh && \
  chown -R ${UID}:${GID} ${WORKDIR} && \
  dnf install -y git make gcc-c++ procps-ng which

RUN if [ -z "${dds_private_version}" ]; then \
  dnf install -y OpenSpliceDDS-${dds_community_version}-${dds_community_build} ; \
  echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl_env.sh ; \
  else \
  dnf install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
  OpenSpliceDDS-${dds_private_version}-${dds_private_build} ; \
  echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_private_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl_env.sh ; \
  fi ; \
  chown -R ${UID}:${GID} ${HOME}/.cache | :

RUN rm /etc/yum.repos.d/lsst-ts-nexus-private.repo

# Make sure that saluser can use the ping command
RUN if [ -f "/bin/ping" ]; then \
    setcap cap_net_raw+ep /bin/ping; \
  fi

USER saluser

WORKDIR ${WORKDIR}

ARG stack

RUN curl -LO https://ls.st/lsstinstall && \
  bash lsstinstall -T ${stack}

RUN source ./loadLSST.bash && \
  eups distrib install -t ${stack} lsst_distrib

ARG ts_dds
ARG ts_ddsconfig
ARG ts_idl
ARG ts_utils
ARG ts_salobj

ENV QT_API="PySide6"
ENV PYTEST_QT_API="PySide6"

WORKDIR ${HOME}

RUN source ${HOME}/.setup_sal_env.sh && \
  conda config --add channels conda-forge && \
  conda config --set solver libmamba && \
  conda install -y cython

RUN source ${HOME}/.setup_sal_env.sh && \
  conda install -y -c lsstts -c lsstts/label/dev \
  ts-xml=${ts_xml} \
  ts-dds=${ts_dds} \
  ts-ddsconfig=${ts_ddsconfig} \
  ts-salobj=${ts_salobj} \
  ts-idl=${ts_idl} \
  ts-utils=${ts_utils} && \
  ddsconfig_path=$(python -c 'from lsst.ts import ddsconfig; import pathlib; print(pathlib.Path(ddsconfig.__file__).parents[0])') && \
  eups declare -m none -r ${ddsconfig_path} ts_ddsconfig ${ts_ddsconfig}  && \
  salobj_path=$(python -c 'from lsst.ts import salobj; import pathlib; print(pathlib.Path(salobj.__file__).parents[0])') && \
  eups declare -m none -r ${salobj_path} ts_salobj ${ts_salobj}  && \
  idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
  eups declare -m none -r ${idl_path} ts_idl ${ts_idl}

# TODO (DM-43904): Remove command to explicity downgrade jaraco.context once this is fixed.
RUN source ./.setup_sal_env.sh && \
    conda install -y jaraco.context=4

USER saluser

WORKDIR /home/saluser/

LABEL dds_community_version=${dds_community_version} \
  dds_community_build=${dds_community_build} \
  dds_private_version=${dds_private_version} \
  dds_private_build=${dds_private_version} \
  stack=${stack} \
  ts_dds=${ts_dds} \
  ts_idl=${ts_idl} \
  ts_ddsconfig=${ts_ddsconfig} \
  ts_salobj=${ts_salobj}

ENTRYPOINT ["/home/saluser/.startup.sh"]
