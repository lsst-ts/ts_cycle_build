ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

USER root

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm && \
    yum install -y centos-release-scl

RUN yum -y --enablerepo=extras install epel-release \
    devtoolset-8-gcc* \
    git \
    make \
    gcc-c++ \
    boost-devel \
    yum clean all

ARG rpm

RUN yum install -y MTMount-${rpm} MTM1M3-${rpm}

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/

USER saluser
WORKDIR /home/saluser/

ARG m1m3=DM-24026

RUN git clone https://github.com/lsst-ts/ts_m1m3support

WORKDIR /home/saluser/ts_m1m3support/
RUN /home/saluser/.checkout_repo.sh ${m1m3} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable devtoolset-8 && \
    make SIMULATOR=1

WORKDIR /home/saluser/

COPY mtm1m3_sim/startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser

ENV RUN_ARG=""

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>
