ARG image_tag

FROM lsstsqre/centos:${image_tag}

USER root

SHELL ["/bin/bash", "-lc"]

WORKDIR /tmp

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-private.repo

ARG  java_v
ARG  osplice_v
ARG  osplice_build
ARG  osplice_py

RUN  yum install -y --enablerepo=extras --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
    openssl \
    dos2unix \
    iproute \
    iptables \
    libmnl \
    libnfnetlink \
    libnetfilter_conntrack \
    "java-${java_v}-openjdk-devel" \
    "OpenSpliceDDS-${osplice_v}-${osplice_build}"

RUN rm -rf /etc/yum.repos.d/lsst-ts-private.repo

ENV OSPL_HOME=/opt/OpenSpliceDDS/V${osplice_v}/HDE/x86_64.linux
ENV  osplice_v=${osplice_v}
ENV  osplice_build=${osplice_build}
ENV  osplice_py=${osplice_py}
