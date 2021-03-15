ARG image_tag

FROM lsstsqre/centos:${image_tag}

ENV USER ${USER:-saluser}
ENV SAL_HOME /home/saluser
ENV WORKDIR /opt/lsst/software/stack

USER root

ARG UID=73006
ARG GID=73006

# Create user and group
RUN if [ $UID -eq 1000 ] && [ $GID -eq 1000 ]; then  \
       echo "Renaming lsst to saluser" && \
       usermod -l saluser lsst && \
       usermod -d /home/saluser -m saluser ; \
    else \
         groupadd --gid ${GID} saluser && \
         adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser ; \
    fi

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-nexus-private.repo
COPY deploy-env/lsstsqre/startup.sh /home/saluser/.startup.sh
COPY deploy-env/lsstsqre/setup_sal_env.sh /opt/lsst/software/stack/.setup_sal_env.sh
COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh

# Create user and group

ARG dds_community_version=6.9.0
ARG dds_community_build=1.el6
ARG dds_private_version
ARG dds_private_build

RUN chown ${UID}:${GID} /home/saluser/.startup.sh && \
    chown ${UID}:${GID} ${WORKDIR}/.setup_sal_env.sh && \
    chown ${UID}:${GID} /home/saluser/.checkout_repo.sh && \
    chmod a+x /home/saluser/.startup.sh && \
    chmod a+x ${WORKDIR}/.setup_sal_env.sh && \
    chmod a+x /home/saluser/.checkout_repo.sh && \
    touch ${WORKDIR}/ospl_env.sh && \
    yum install -y git make gcc-c++

RUN if [ -z "${dds_private_version}" ]; then \
      yum install -y OpenSpliceDDS-${dds_community_version}-${dds_community_build} ; \
      echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl_env.sh ; \
    else \
      yum install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
      OpenSpliceDDS-${dds_private_version}-${dds_private_build} ; \
      echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_private_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl_env.sh ; \
    fi

RUN rm /etc/yum.repos.d/lsst-ts-nexus-private.repo

USER lsst
WORKDIR ${WORKDIR}

ARG ts_dds
ARG ts_ddsconfig
ARG ts_idl
ARG ts_salobj

RUN source ${WORKDIR}/.setup_sal_env.sh && \
    conda config --add channels conda-forge && \
    conda install -y cython && \
    conda install -y -c lsstts -c lsstts/label/dev ts-dds=${ts_dds} ts-ddsconfig=${ts_ddsconfig} ts-salobj=${ts_salobj} ts-idl=${ts_idl} && \
    ddsconfig_path=$(python -c 'from lsst.ts import ddsconfig; import pathlib; print(pathlib.Path(ddsconfig.__file__).parents[0])') && \
    eups declare -m none -r ${ddsconfig_path} ts_ddsconfig ${ts_ddsconfig}  && \
    salobj_path=$(python -c 'from lsst.ts import salobj; import pathlib; print(pathlib.Path(salobj.__file__).parents[0])') && \
    eups declare -m none -r ${salobj_path} ts_salobj ${ts_salobj}  && \
    idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
    eups declare -m none -r ${idl_path} ts_idl ${ts_idl}

USER saluser

WORKDIR /home/saluser/

LABEL dds_community_version=${dds_community_version} \
      dds_community_build=${dds_community_build} \
      dds_private_version=${dds_private_version} \
      dds_private_build=${dds_private_version} \
      ts_dds=${ts_dds} \
      ts_idl=${ts_idl} \
      ts_ddsconfig=${ts_ddsconfig} \
      ts_salobj=${ts_salobj}

ENTRYPOINT ["/home/saluser/.startup.sh"]
