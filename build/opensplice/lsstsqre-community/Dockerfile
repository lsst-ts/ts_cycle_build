ARG image_tag

FROM lsstsqre/centos:${image_tag}

USER root

SHELL ["/bin/bash", "-lc"]

WORKDIR /tmp

ENV QT_API="PySide6"
ENV PYTEST_QT_API="PySide6"

RUN sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo && \
    sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo && \
    sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo

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

ENV OSPL_HOME=/opt/OpenSpliceDDS/V${osplice_v}/HDE/x86_64.linux
ENV  osplice_v=${osplice_v}
ENV  osplice_build=${osplice_build}
ENV  osplice_py=${osplice_py}
