FROM centos:centos7

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG UID=73006
ARG GID=73006

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN groupadd -g ${GID} lsst && adduser -u ${UID} -m -g lsst -s /bin/bash saluser

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-nexus-private.repo

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm && \
    yum install -y centos-release-scl cmake

RUN yum -y --enablerepo=extras install epel-release \
    devtoolset-8-gcc* \
    wget \
    git \
    make \
    wget \
    gcc-c++ \
    boost-python \
    boost-python-devel \
    curl-devel \
    yum clean all

ARG rpm=0:4.1.0-5.0.0.el7.x86_64
ARG dds_private_version
ARG dds_private_build
ARG dds_version

ENV OSPL_HOME=/opt/OpenSpliceDDS/V${dds_version}/HDE/x86_64.linux

RUN if [ -z "${dds_private_version}" ]; then \
    yum install -y OpenSpliceDDS-6.9.0-8 MTMount-${rpm} MTM1M3-${rpm} ;\
  else \
    yum install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
    OpenSpliceDDS-${dds_private_version}-${dds_private_build}.x86_64 \
    MTMount-${rpm} MTM1M3-${rpm} ; \
  fi; \
  rm /etc/yum.repos.d/lsst-ts-nexus-private.repo

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV LSST_DDS_DOMAIN=citest

USER saluser
WORKDIR /home/saluser/

ARG m1m3=DM-24026
RUN git clone --branch ${m1m3} https://github.com/lsst-ts/ts_m1m3support

WORKDIR /home/saluser/ts_m1m3support/
RUN source scl_source enable devtoolset-8 && \
    source ${OSPL_HOME}/release.com && \
    make SIMULATOR=1

WORKDIR /home/saluser/

COPY mtm1m3_sim/startup.sh /home/saluser/.setup.sh

ARG ts_idl
RUN git clone --branch ${ts_idl} https://github.com/lsst-ts/ts_idl.git

ENV LSST_DDS_QOS=file:///home/saluser/ts_idl/qos/QoS.xml

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
