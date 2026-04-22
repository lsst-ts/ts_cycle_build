ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Petr Kubánek <petr.kubanek@noirlab.edu>

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
    iproute \
    jansson-devel \
    gcc-toolset-14 \
    git \
    libcurl-devel \
    make \
    openssl \
    patch \
    snappy \
    spdlog-devel \
    zlib-devel && \
    dnf clean all

RUN mkdir -p /opt/lsst/tssw 

WORKDIR /opt/lsst/tssw

RUN git clone https://github.com/apache/avro \
    && source scl_source enable gcc-toolset-14 \
    && cd avro/lang/c \
    && cmake . && make && make install \
    && cd ../c++ && cmake . && make && make install

RUN cd /opt/lsst/tssw && git clone https://github.com/confluentinc/libserdes 

COPY deploy-crio/libserdes.patch /opt/lsst/tssw/libserdes
RUN cd libserdes \
    && patch -p1 < libserdes.patch

RUN source /home/saluser/.setup_sal_env.sh \
    && export CPATH="/usr/local/include" \
    && export LIBRARY_PATH="/usr/local/lib64:/opt/lsst/tssw/ts_sal/lib" \
    && source scl_source enable gcc-toolset-14 \
    && cd /opt/lsst/tssw/libserdes && ./configure && make && make install

ARG sal
ARG xml

RUN source /home/saluser/.setup_sal_env.sh \
    && cd /opt/lsst/tssw \
    && git clone https://github.com/lsst-ts/ts_sal \
    && cd ts_sal \
    && git checkout $sal \
    && cd .. \
    && git clone https://github.com/lsst-ts/ts_xml \
    && cd ts_xml \
    && git checkout $xml

RUN chown -R saluser.saluser /opt/lsst/tssw

RUN mkdir -p /opt/lsst/tssw/ts_sal/test && chown saluser.saluser /opt/lsst/tssw/ts_sal/test

USER saluser

ARG xml

RUN source /home/saluser/.setup_sal_env.sh \
    && mamba install -y -c lsstts readline yaml-cpp catch2 spdlog texlive-core ghostscript ts-xml=$xml

WORKDIR /home/saluser

RUN source /home/saluser/.setup_sal_env.sh \
    && echo > /home/saluser/.crio_setup.sh -e \
echo "Configuring cRIO development environment" \\n\
export SAL_HOME=/opt/lsst/tssw/ts_sal/lsstsal\\n\
export SAL_WORK_DIR=/opt/lsst/tssw/ts_sal/test\\n\
export LSST_KAFKA_PREFIX=sal\\n\
export LSST_KAFKA_SECURITY_MECHANISM=SCRAM-SHA-512\\n\
export LSST_KAFKA_CLASSDIR=/opt/lsst/tssw/ts_sal/lib\\n\
export LSST_KAFKA_HOST=broker\\n\
export LSST_KAFKA_IP=\\n\
export LSST_KAFKA_LOCAL_SCHEMAS=/opt/lsst/tssw/ts_sal/test\\n\
export LSST_KAFKA_BROKER_PORT=29092\\n\
export LSST_KAFKA_BROKER_ADDR=broker:29092\\n\
export LSST_KAFKA_SECURITY_PROTOCOL=SASL_SSL\\n\
export AVRO_RELEASE=1.11.3\\n\
export LSST_TOPIC_SUBNAME=sal\\n\
\\n\
export LSST_KAFKA_BROKER_ADDR="broker:29092"\\n\
export LSST_SCHEMA_REGISTRY_URL="http://schema-registry:8081"\\n\
\\n\
export LSST_SAL_PREFIX=/usr/local\\n\
\\n\
export LSST_KAFKA_HOST=${LSST_KAFKA_BROKER_ADDR%:*}\\n\
export LSST_KAFKA_BROKER_PORT=${LSST_KAFKA_BROKER_ADDR##*:}\\n\
export LSST_KAFKA_PREFIX=sal\\n\
export LSST_KAFKA_LOCAL_SCHEMAS=$SAL_WORK_DIR\\n\
\\n\
export TS_CONFIG_OCS_DIR=/lsst/ts_config_ocs/\\n\
\\n\
export LIBRARY_PATH=/usr/local/lib64:/usr/local/lib:/opt/lsst/tssw/ts_sal/lib\\n\
export CONDA_PREFIX=/opt/lsst/software/stack/miniconda\\n\
\\n\
source /home/saluser/.setup_sal_env.sh\\n\
source /opt/lsst/tssw/ts_sal/setupKafka.env\\n\
\\n\
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:$CONDA_PREFIX/lib/pkgconfig\\n\
\\n\
source scl_source enable gcc-toolset-14\\n\
\\n\
export CPATH=\"/usr/local/include\"\\n\
export LD_LIBRARY_PATH="$CONDA_PREFIX/lib:/usr/local/lib64:/usr/local/lib"\\n\
\\n\
export SAL_DIR=/opt/lsst/tssw/ts_sal/lsstsal/scripts\\n\
export TS_XML_DIR=/opt/lsst/tssw/ts_xml

ARG crio_cpp

RUN source /home/saluser/.crio_setup.sh \
    && git clone https://github.com/lsst-ts/ts_cRIOcpp \
    && cd ts_cRIOcpp \
    && /home/saluser/.checkout_repo.sh ${crio_cpp} \
    && make -j$(nproc)

ARG config

RUN git clone https://github.com/lsst-ts/ts_config_mttcs \
    && cd ts_config_mttcs \
    && /home/saluser/.checkout_repo.sh ${config}
