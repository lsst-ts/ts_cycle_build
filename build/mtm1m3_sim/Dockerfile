ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

RUN dnf install -y dnf-plugins-core epel-release && \
    dnf config-manager --set-enabled powertools && \
    dnf -y --enablerepo=extras install make \
    gcc-toolset-11 \
    git \
    catch-devel \
    boost1.78 \
    boost1.78-devel \
    readline-devel \
    spdlog-devel \
    yaml-cpp-devel && \
    dnf clean all

ARG rpm

RUN dnf install -y \
    --enablerepo=lsst-ts-test \
    MTM1M3-20.2.0-8.0.0.el8 \
    MTMount-20.2.0-8.0.0.el8

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV SAL_WORK_DIR=/opt/lsst/ts_sal
ENV LSST_SAL_PREFIX=/opt/lsst/ts_sal

USER saluser
WORKDIR /home/saluser/

ARG m1m3
ARG crio_cpp

RUN git clone https://github.com/lsst-ts/ts_m1m3support && \
    git clone https://github.com/lsst-ts/ts_cRIOcpp

WORKDIR /home/saluser/ts_cRIOcpp/

# RUN /home/saluser/.checkout_repo.sh ${crio_cpp} && \

RUN git checkout davemills/DM-41747 && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-11 && \
    sed -i 's/boost169/boost1.78/' Makefile.inc && \
    make

WORKDIR /home/saluser/ts_m1m3support/

RUN git checkout davemills/DM-41747 && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-11 && \
    make SIMULATOR=1 VERBOSE=1 || echo "Compilation failed... Continuing..."

WORKDIR /home/saluser/

COPY mtm1m3_sim/startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser

ENV RUN_ARG=""
