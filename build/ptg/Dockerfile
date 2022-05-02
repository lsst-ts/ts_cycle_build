ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

USER root

RUN dnf install -y dnf-plugins-core epel-release && \
    dnf config-manager --set-enabled powertools && \
    dnf -y --enablerepo=extras install make \
    gcc-toolset-10 \
    wget \
    git \
    make \
    cmake \
    wget \
    boost-python3 \
    boost-python3-devel \
    curl-devel && \
    dnf clean all

ARG rpm

RUN dnf install -y \
    ATPtg-${rpm} \
    MTPtg-${rpm} \
    MTMount-${rpm} \
    MTRotator-${rpm} \
    WeatherStation-${rpm} \
    ATMCS-${rpm} \
    Guider-${rpm}

RUN mkdir /home/saluser/.ssh/ && chown saluser:saluser /home/saluser/.ssh/ && chmod 700 /home/saluser/.ssh/
COPY ptg/id_rsa /home/saluser/.ssh/

RUN chown saluser:saluser /home/saluser/.ssh/id_rsa && \
    ssh-keyscan -H github.com >> /home/saluser/.ssh/known_hosts && \
    chown saluser:saluser /home/saluser/.ssh/known_hosts && \
    chmod 400 /home/saluser/.ssh/id_rsa && \
    chmod 644 /home/saluser/.ssh/known_hosts

USER saluser
WORKDIR /home/saluser

RUN mkdir repos

WORKDIR /home/saluser/repos

RUN git clone git@github.com:lsst-ts/tcspk_source_lsst_161203.git && \
    git clone git@github.com:lsst-ts/slalib_source_lsst_161203.git && \
    git clone git@github.com:lsst-ts/ts_pointing_common.git

WORKDIR /home/saluser/repos/ts_pointing_common

WORKDIR /home/saluser

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.5.4/
ENV LSST_DDS_DOMAIN=citest
ENV PYTHONPATH=${PYTHONPATH}:/opt/lsst/ts_sal/lib/
ENV PTG_CONFIG_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV PTG_DATA_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV LSST_TOP=/home/saluser/repos/ts_pointing_common
ENV SLALIB_DIR=/home/saluser/repos/slalib_source_lsst_161203
ENV TCSPK_DIR=/home/saluser/repos/tcspk_source_lsst_161203
ENV LSST_TS_XML_DIR=/home/saluser/repos/ts_xml
ENV TELESCOPE=MT

WORKDIR /home/saluser/repos/slalib_source_lsst_161203
RUN source scl_source enable gcc-toolset-10 && make

WORKDIR /home/saluser/repos/tcspk_source_lsst_161203
RUN source scl_source enable gcc-toolset-10 && make

WORKDIR /home/saluser/repos/ts_pointing_common
RUN mkdir build

ARG ptg
WORKDIR /home/saluser/repos/ts_pointing_common/build
RUN /home/saluser/.checkout_repo.sh ${ptg} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-10 && \
    cmake -DRPM=ON .. && make && \
    cmake -DRPM=ON -DAT=ON .. && make

RUN mkdir -p $PTG_DATA_DIR && cp $LSST_TOP/src/data/* $PTG_DATA_DIR/

COPY ptg/startup.sh /home/saluser/.startup.sh

COPY ptg/ATPtg.info /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/MTPtg.info /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_20200219_fauto.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_20200219_manual.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_20200314_fauto.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_20210323.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_202103_multi_run_fit.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_20210817_fauto_corr_full.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_20210817_fauto_corr.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_20210817_ia_ie_ca_an_aw_tf_corr_full.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_20210817_ia_ie_ca_an_aw_tf_corr_outlier_rej.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/AT_point_data_20210906_tw004_fauto.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/AT_point_data_20210906_tw004_ia_ie_ca_an_aw_tf.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/AT_point_data_20210906_tw004_corr_fauto.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/AT_point_data_20210906_tw004_corr_ia_ie_ca_an_aw_tf.mod /home/saluser/repos/ts_pointing_common/install/data/
COPY ptg/at_202111_ia_ie_ca_an_aw_tf_tx10.mod /home/saluser/repos/ts_pointing_common/install/data/at_202111_ia_ie_ca_an_aw_tf_tx10.mod
COPY ptg/at_20220406_fauto.mod /home/saluser/repos/ts_pointing_common/install/data/at_20220406_fauto.mod
COPY ptg/at_20220406_ia_ie_an_aw_tx10_ca.mod /home/saluser/repos/ts_pointing_common/install/data/at_20220406_ia_ie_an_aw_tx10_ca.mod
COPY ptg/at_20220406_ia_ie_an_aw_tx10_ca.mod /home/saluser/repos/ts_pointing_common/install/data/at.mod

USER root
RUN chown -R saluser:saluser /home/saluser/repos/ts_pointing_common/install/data/ && \
    chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
