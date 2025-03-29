ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

RUN dnf install -y dnf-plugins-core epel-release && \
    dnf -y --enablerepo=extras install make \
    git \
    catch-devel \
    boost1.78 \
    boost1.78-devel \
    readline-devel \
    snappy-devel \
    spdlog-devel \
    jansson \
    iproute \
    yaml-cpp-devel cyrus-sasl-devel && \
    dnf clean all

RUN ln -s /usr/lib64/libboost_filesystem.so.1.78.0 /usr/lib64/libboost_filesystem.so && \
    ln -s /usr/lib64/libboost_iostreams.so.1.78.0 /usr/lib64/libboost_iostreams.so && \
    ln -s /usr/lib64/libboost_program_options.so.1.78.0 /usr/lib64/libboost_program_options.so && \
    ln -s /usr/lib64/libboost_system.so.1.78.0 /usr/lib64/libboost_system.so && \
    ln -s /usr/lib64/libcurl.so.4 /usr/lib64/libcurl.so && \
    ln -s /usr/lib64/libjansson.so.4 /usr/lib64/libjansson.so

ARG rpm

RUN dnf install -y \
    --enablerepo=lsst-ts \
    --disablerepo=lsst-ts-test \
    MTM1M3TS-${rpm}

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
    # source scl_source enable gcc-toolset-11 && \
    sed -i 's/boost169/boost1.78/' Makefile.inc && \
    make

ENV WITH_SAL_KAFKA=1

WORKDIR /home/saluser/ts_m1m3thermal/

RUN /home/saluser/.checkout_repo.sh ${m1m3ts} && \
    source /home/saluser/.setup_sal_env.sh && \
    # source scl_source enable gcc-toolset-11 && \
    make simulator

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
