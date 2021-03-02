ARG image_tag=7-stack-lsst_distrib-w_2021_04

FROM lsstsqre/centos:${image_tag}

ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.10.4/HDE/x86_64.linux
# ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux

USER root

RUN yum install -y mlocate
RUN adduser -u 1004 -m -s /bin/bash saluser
RUN yum install -y iproute gcc-c++ make ncurses-libs xterm xorg-x11-fonts-misc java-1.7.0-openjdk-devel maven python-devel swig git tk-devel wget bzip2

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-nexus-private.repo

RUN yum install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts OpenSpliceDDS-6.10.4
# RUN yum install -y OpenSpliceDDS-6.9.0-9.el7 && cp /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/bin/idlpp /tmp/idlpp && yum install -y OpenSpliceDDS-6.9.0-11.el7 && cp /tmp/idlpp /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/bin/idlpp
USER saluser
WORKDIR /home/saluser
