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

ARG rpm

RUN dnf install -y \
    --enablerepo=lsst-ts \
    --disablerepo=lsst-ts-test \
    MTM1M3-${rpm} \
    MTMount-${rpm}

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

COPY libserdes.patch /opt/lsst/libserdes
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

ARG m1m3
ARG crio_cpp
ARG config

RUN git clone https://github.com/lsst-ts/ts_m1m3support && \
    git clone https://github.com/lsst-ts/ts_cRIOcpp && \
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

ENV WITH_SAL_KAFKA=1
WORKDIR /home/saluser/ts_m1m3support/

RUN source /home/saluser/.startup.sh && \
    /home/saluser/.checkout_repo.sh ${m1m3} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-14 && \
    export PKG_CONFIG_PATH=/opt/lsst/software/stack/miniconda/lib/pkgconfig/ && \
    make simulator

WORKDIR /home/saluser/

COPY startup.sh /home/saluser/.startup.sh
COPY sal_setup.sh /home/saluser/.sal_setup.sh
COPY create_topics_mtm1m3.py /home/saluser/.create_topics_mtm1m3.py
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chown saluser:saluser /home/saluser/.create_topics_mtm1m3.py && \
    chmod a+x /home/saluser/.create_topics_mtm1m3.py && \
    chmod a+x /home/saluser/.startup.sh
USER saluser

ENV RUN_ARG=""
