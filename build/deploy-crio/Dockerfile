ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

RUN dnf install -y dnf-plugins-core epel-release && \
    dnf -y --enablerepo=extras install \
    boost \
    boost-atomic \
    boost-devel \
    boost-filesystem \
    boost-iostreams \
    boost-program-options \
    boost-regex \
    boost-system \
    cmake \
    jansson-devel \
    gcc-toolset-14 \
    git \
    libcurl-devel \
    make \
    openssl \
    patch \
    snappy \
    zlib-devel && \
    dnf clean all

RUN source /home/saluser/.startup.sh && \
    mamba install -y readline spdlog catch2 yaml-cpp

RUN rm -rf /opt/lsst/ts_sal/include/avro* \
    && rm -rf /opt/lsst/ts_sal/lib/libavro* /opt/lsst/ts_sal/lib/lib*kafka*

RUN cd /opt/lsst/ && git clone https://github.com/apache/avro 

RUN source /home/saluser/.startup.sh \
    && source scl_source enable gcc-toolset-14 \
    && cd /opt/lsst/avro/lang/c \
    && cmake . && make && make install \
    && cd ../c++ && cmake . && make && make install

RUN cd /opt/lsst/ && git clone https://github.com/confluentinc/libserdes 

COPY deploy-crio/libserdes.patch /opt/lsst/libserdes
RUN source /home/saluser/.startup.sh \
    && cd /opt/lsst/libserdes \
    && patch -p1 < libserdes.patch

RUN source /home/saluser/.startup.sh \
    && export LIBRARY_PATH="/usr/local/lib64:/opt/lsst/tssw/ts_sal/lib" \
    && export PKG_CONFIG_PATH="/usr/lib64/pkgconfig:/opt/lsst/software/stack/miniconda/lib/pkgconfig" \
    && source scl_source enable gcc-toolset-14 \
    && export CXXFLAGS=-I/opt/lsst/software/stack/miniconda/include/ \
    && cd /opt/lsst/libserdes && ./configure && make && make install

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV SAL_WORK_DIR=/opt/lsst/ts_sal/
ENV LSST_SAL_PREFIX=/opt/lsst/ts_sal/

USER saluser
WORKDIR /home/saluser/

ARG crio_cpp
ARG config

RUN git clone https://github.com/lsst-ts/ts_cRIOcpp && \
    git clone https://github.com/lsst-ts/ts_config_mttcs.git

WORKDIR /home/saluser/ts_config_mttcs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/ts_cRIOcpp/
RUN source /home/saluser/.startup.sh && \
    /home/saluser/.checkout_repo.sh ${crio_cpp} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-14 && \
    export PKG_CONFIG_PATH=/opt/lsst/software/stack/miniconda/lib/pkgconfig/ && \
    make

WORKDIR /home/saluser/

COPY sal_setup.sh /home/saluser/.sal_setup.sh

ENV RUN_ARG=""
