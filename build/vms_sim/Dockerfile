ARG cycle
ARG hub

FROM ${hub}/deploy-crio:${cycle}

LABEL maintainer Wouter van Reeven <wvreeven@lsst.org>

USER root

ARG rpm

RUN dnf install -y \
    --enablerepo=lsst-ts \
    --disablerepo=lsst-ts-test \
    MTVMS-${rpm} fftw3-devel
    
RUN rm -rf /opt/lsst/ts_sal/include/avro* \
    && rm -rf /opt/lsst/ts_sal/lib/libavro* /opt/lsst/ts_sal/lib/lib*kafka*

USER saluser
WORKDIR /home/saluser/

ARG vms

RUN git clone https://github.com/lsst-ts/ts_vms

ENV WITH_SAL_KAFKA=1

WORKDIR /home/saluser/ts_vms/

RUN /home/saluser/.checkout_repo.sh ${vms} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-14 && \
    export PKG_CONFIG_PATH=/opt/lsst/software/stack/miniconda/lib/pkgconfig/ && \
    make -j$(nproc) simulator

WORKDIR /home/saluser/

USER root
COPY --chown=saluser:saluser --chmod=a+x vms_sim/startup.sh /home/saluser/.startup.sh
COPY --chown=saluser:saluser --chmod=a+x vms_sim/sal_setup.sh /home/saluser/.sal_setup.sh
COPY --chown=saluser:saluser --chmod=a+x vms_sim/create_topics_vms.py /home/saluser/.create_topics_vms.py
USER saluser

ENV RUN_ARG=""
