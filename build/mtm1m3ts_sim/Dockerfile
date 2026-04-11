ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

RUN dnf install -y dnf-plugins-core epel-release && \
    dnf -y --enablerepo=extras install make \
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
    MTM1M3TS-${rpm}
    
RUN source /home/saluser/.startup.sh && \
    mamba install -y readline spdlog catch2 yaml-cpp

RUN rm -rf /opt/lsst/ts_sal/include/avro* \
    && rm -rf /opt/lsst/ts_sal/lib/libavro* /opt/lsst/ts_sal/lib/lib*kafka*

RUN cd /opt/lsst/ && git clone https://github.com/apache/avro 

RUN source /home/saluser/.startup.sh \
    && source scl_source enable gcc-toolset-14 \
    && cd /opt/lsst/avro/lang/c \
    && cmake . && make -j$(nproc) && make install \
    && cd ../c++ && cmake . && make -j$(nproc) && make install

RUN cd /opt/lsst/ && git clone https://github.com/confluentinc/libserdes 

COPY mtm1m3_sim/libserdes.patch /opt/lsst/libserdes
RUN source /home/saluser/.startup.sh \
    && cd /opt/lsst/libserdes \
    && patch -p1 < libserdes.patch

RUN source /home/saluser/.startup.sh \
    && export LIBRARY_PATH="/usr/local/lib64:/opt/lsst/tssw/ts_sal/lib" \
    && export PKG_CONFIG_PATH="/usr/lib64/pkgconfig:/opt/lsst/software/stack/miniconda/lib/pkgconfig" \
    && source scl_source enable gcc-toolset-14 \
    && export CXXFLAGS=-I/opt/lsst/software/stack/miniconda/include/ \
    && cd /opt/lsst/libserdes && ./configure && make -j$(nproc) && make install

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV SAL_WORK_DIR=/opt/lsst/ts_sal/
ENV LSST_SAL_PREFIX=/opt/lsst/ts_sal/

USER saluser
WORKDIR /home/saluser/

ARG m1m3ts
ARG crio_cpp
ARG config

RUN git clone https://github.com/lsst-ts/ts_m1m3thermal && \
    git clone https://github.com/lsst-ts/ts_cRIOcpp && \
    git clone https://github.com/lsst-ts/ts_config_mttcs.git

WORKDIR /home/saluser/ts_config_mttcs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/ts_cRIOcpp/

RUN /home/saluser/.checkout_repo.sh ${crio_cpp} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-14 && \
    export PKG_CONFIG_PATH=/opt/lsst/software/stack/miniconda/lib/pkgconfig/ && \
    make -j$(nproc)

ENV WITH_SAL_KAFKA=1

WORKDIR /home/saluser/ts_m1m3thermal/

COPY mtm1m3ts_sim/0001-Comment-out-flow-publisher.patch /home/saluser/ts_m1m3thermal/

RUN /home/saluser/.checkout_repo.sh ${m1m3ts} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-14 && \
    export PKG_CONFIG_PATH=/opt/lsst/software/stack/miniconda/lib/pkgconfig/ && \
    patch -p1 < 0001-Comment-out-flow-publisher.patch && \
    make -j$(nproc) simulator

WORKDIR /home/saluser/

COPY mtm1m3ts_sim/startup.sh /home/saluser/.startup.sh
COPY mtm1m3ts_sim/sal_setup.sh /home/saluser/.sal_setup.sh
COPY mtm1m3ts_sim/create_topics_mtm1m3ts.py /home/saluser/.create_topics_mtm1m3ts.py
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chown saluser:saluser /home/saluser/.create_topics_mtm1m3ts.py && \
    chmod a+x /home/saluser/.create_topics_mtm1m3ts.py && \
    chmod a+x /home/saluser/.startup.sh
USER saluser

ENV RUN_ARG=""
