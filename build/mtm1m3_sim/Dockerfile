ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

RUN dnf install -y dnf-plugins-core epel-release && \
    dnf config-manager --set-enabled powertools && \
    dnf -y --enablerepo=extras install make \
    gcc-toolset-10 \
    git \
    gcc-c++ \
    catch-devel \
    boost169-devel \
    readline-devel \
    yaml-cpp-devel && \
    dnf clean all

ARG rpm

RUN dnf install -y MTMount-${rpm} MTM1M3-${rpm}

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV SAL_WORK_DIR=/opt/lsst/ts_sal

USER saluser
WORKDIR /home/saluser/

ARG m1m3
ARG crio_cpp
ARG spdlog

RUN git clone https://github.com/lsst-ts/ts_m1m3support && \
    git clone https://github.com/lsst-ts/ts_cRIOcpp && \
    git clone https://github.com/gabime/spdlog

WORKDIR /home/saluser/spdlog
RUN /home/saluser/.checkout_repo.sh ${spdlog}
USER root
RUN cp -r include/spdlog/ /usr/include
USER saluser

WORKDIR /home/saluser/ts_cRIOcpp/
RUN /home/saluser/.checkout_repo.sh ${crio_cpp} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-10 && \
    make

WORKDIR /home/saluser/ts_m1m3support/
RUN /home/saluser/.checkout_repo.sh ${m1m3} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-10 && \
    make simulator

WORKDIR /home/saluser/

COPY mtm1m3_sim/startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser

ENV RUN_ARG=""
