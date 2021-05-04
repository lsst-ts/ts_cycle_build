ARG image_tag

FROM lsstsqre/centos:${image_tag}

USER root

SHELL ["/bin/bash", "-lc"]

WORKDIR /tmp

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo

ARG  java_v
ARG  osplice_v
ARG  osplice_build
ARG  osplice_py

RUN  yum install -y --enablerepo=extras \
      dos2unix \
      iproute \
      iptables \
      libmnl \
      libnfnetlink \
      libnetfilter_conntrack \
      "java-${java_v}-openjdk-devel" \
      "OpenSpliceDDS-${osplice_v}-${osplice_build}"

WORKDIR /usr/share/zoneinfo

RUN curl https://www.ietf.org/timezones/data/leap-seconds.list -o leap-seconds.list

ENV LOADSTACK=/opt/lsst/software/stack/loadLSST.bash

RUN source ${LOADSTACK} && \
     conda install -c conda-forge -y \
      librdkafka aiokafka astroquery asynctest \
      ephem kafkacat pre-commit pytest-tornasync \
      setuptools_scm pytest-black


ENV SRCDIR=/opt/lsst/src
ENV SALSTACK=/opt/lsst/sal/salbldsteps.bash
ENV OSPL_HOME=/opt/OpenSpliceDDS/V${osplice_v}/HDE/x86_64.linux
ENV TZ="UTC"

RUN mkdir -p /opt/lsst/sal
COPY sal-sciplat/salbldsteps.bash /opt/lsst/sal

#### Clear the astropy download cache
RUN source ${LOADSTACK} && \
    python3 -c 'from astropy.utils.data import clear_download_cache; \
                clear_download_cache()'

ARG black_v

# If we are pinning back black, we need to explicitly downgrade it.
RUN source ${LOADSTACK} && \
    conda install -c conda-forge -y black=${black_v}

# Conda install TSSW packages that are frozen. These are seldom changed by
# users during operations.

ARG ts_ddsconfig
ARG ts_xml
ARG ts_idl
ARG ts_sal
ARG ts_salobj
ARG ts_atdome
ARG ts_atdometrajectory
ARG ts_atmcssimulator

RUN source ${SALSTACK} && \
    conda install -c lsstts -y \
    ts-dds=${osplice_v}=${osplice_py} \
    ts-ddsconfig=${ts_ddsconfig} \
    ts-idl=${ts_idl}_${ts_xml}_${ts_sal} \
    ts-salobj=${ts_salobj} \
    ts-atdome=${ts_atdome} \
    ts-atdometrajectory=${ts_atdometrajectory} \
    ts-atmcs-simulator=${ts_atmcssimulator} && \
    ddsconfig_path=$(python -c 'from lsst.ts import ddsconfig; import pathlib; print(pathlib.Path(ddsconfig.__file__).parents[0])') && \
    eups declare -m none -r ${ddsconfig_path} ts_ddsconfig ${ts_ddsconfig}  && \
    salobj_path=$(python -c 'from lsst.ts import salobj; import pathlib; print(pathlib.Path(salobj.__file__).parents[0])') && \
    eups declare -m none -r ${salobj_path} ts_salobj ${ts_salobj}  && \
    idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
    eups declare -m none -r ${idl_path} ts_idl ${ts_idl}_${ts_xml}_${ts_sal} && \
    atdome_path=$(python -c 'from lsst.ts import ATDome; import pathlib; print(pathlib.Path(ATDome.__file__).parents[0])') && \
    eups declare -m none -r ${atdome_path} ts_ATDome ${ts_atdome} && \
    atdometrajectory_path=$(python -c 'from lsst.ts import ATDomeTrajectory; import pathlib; print(pathlib.Path(ATDomeTrajectory.__file__).parents[0])') && \
    eups declare -m none -r ${atdometrajectory_path} ts_ATDomeTrajectory ${ts_atdometrajectory} && \
    atmcssimulator_path=$(python -c 'from lsst.ts import ATMCSSimulator; import pathlib; print(pathlib.Path(ATMCSSimulator.__file__).parents[0])') && \
    eups declare -m none -r ${atmcssimulator_path} ts_ATMCSSimulator ${ts_atmcssimulator}

ARG ts_config_ocs
ARG ts_config_attcs
ARG ts_config_mtcalsys
ARG ts_config_eas
ARG ts_config_latiss
ARG ts_config_mttcs
ARG ts_config_atcalsys
ARG ts_observatory_control
ARG ts_standardscripts
ARG ts_externalscripts

# Only clone and setup the packages that are really necessary to be managed
# with eups. Everything else is installed using conda.
WORKDIR ${SRCDIR}
RUN source ${LOADSTACK} && \
    gitsrc="ts_config_ocs:${ts_config_ocs} \
            ts_config_attcs:${ts_config_attcs} \
            ts_config_mtcalsys:${ts_config_mtcalsys} \
            ts_config_eas:${ts_config_eas} \
            ts_config_latiss:${ts_config_latiss} \
            ts_config_mttcs:${ts_config_mttcs} \
            ts_config_atcalsys:${ts_config_atcalsys} \
            ts_observatory_control:${ts_observatory_control} \
            ts_standardscripts:${ts_standardscripts} \
            ts_externalscripts:${ts_externalscripts}" && \
    rb="https://github.com/lsst-ts" && \
    set -e && \
    for g in $gitsrc ; do \
        r=$(echo ${g} | cut -d ':' -f 1) \
        t=$(echo ${g} | cut -d ':' -f 2) ;\
        git clone --branch v${t} --depth 1 --single-branch ${rb}/${r}.git ; \
        cd ${r} ; \
        git checkout -b ${t} ; \
        eups declare -r . -t current ${r} ${t}; \
        cd .. ; \
    done

# Building eups packages
WORKDIR ${SRCDIR}/ts_observatory_control
RUN source ${SALSTACK} && \
    export LSST_DDS_DOMAIN_ID=$(( RANDOM % 230 )) && \
    export OSPL_URI=$(python -c "from lsst.ts import ddsconfig; print( (ddsconfig.get_config_dir() / 'ospl-std.xml').as_uri())") && \
    setup ts_config_ocs && \
    setup ts_observatory_control && \
    scons

WORKDIR ${SRCDIR}/ts_standardscripts
RUN source ${SALSTACK} && \
    export LSST_DDS_DOMAIN_ID=$(( RANDOM % 230 )) && \
    export OSPL_URI=$(python -c "from lsst.ts import ddsconfig; print( (ddsconfig.get_config_dir() / 'ospl-std.xml').as_uri())") && \
    setup ts_config_attcs && \
    setup ts_standardscripts && \
    scons

WORKDIR ${SRCDIR}/ts_externalscripts
RUN source ${SALSTACK} && \
    export LSST_DDS_DOMAIN_ID=$(( RANDOM % 230 )) && \
    export OSPL_URI=$(python -c "from lsst.ts import ddsconfig; print( (ddsconfig.get_config_dir() / 'ospl-std.xml').as_uri())") && \
    setup ts_externalscripts && \
    scons || echo FAILED to build ts_externalscripts

USER lsst
WORKDIR /opt/lsst/software/stack/
