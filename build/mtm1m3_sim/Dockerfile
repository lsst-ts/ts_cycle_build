ARG cycle
ARG hub

FROM ${hub}/deploy-crio:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

ARG rpm

RUN dnf install -y \
    --enablerepo=lsst-ts \
    --disablerepo=lsst-ts-test \
    MTM1M3-${rpm} \
    MTMount-${rpm}
    
RUN rm -rf /opt/lsst/ts_sal/include/avro* \
    && rm -rf /opt/lsst/ts_sal/lib/libavro* /opt/lsst/ts_sal/lib/lib*kafka*

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV SAL_WORK_DIR=/opt/lsst/ts_sal/
ENV LSST_SAL_PREFIX=/opt/lsst/ts_sal/

USER saluser
WORKDIR /home/saluser/

ARG m1m3
ARG crio_cpp
ARG config

RUN git clone https://github.com/lsst-ts/ts_m1m3support

ENV WITH_SAL_KAFKA=1
WORKDIR /home/saluser/ts_m1m3support/

RUN source /home/saluser/.startup.sh && \
    /home/saluser/.checkout_repo.sh ${m1m3} && \
    source /home/saluser/.setup_sal_env.sh && \
    source scl_source enable gcc-toolset-14 && \
    export PKG_CONFIG_PATH=/opt/lsst/software/stack/miniconda/lib/pkgconfig/ && \
    make -j$(nproc) simulator

WORKDIR /home/saluser/

COPY mtm1m3_sim/startup.sh /home/saluser/.startup.sh
COPY mtm1m3_sim/sal_setup.sh /home/saluser/.sal_setup.sh
COPY mtm1m3_sim/create_topics_mtm1m3.py /home/saluser/.create_topics_mtm1m3.py
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chown saluser:saluser /home/saluser/.create_topics_mtm1m3.py && \
    chmod a+x /home/saluser/.create_topics_mtm1m3.py && \
    chmod a+x /home/saluser/.startup.sh
USER saluser

ENV RUN_ARG=""
