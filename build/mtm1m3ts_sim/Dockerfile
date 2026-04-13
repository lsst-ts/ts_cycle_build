ARG cycle
ARG hub

FROM ${hub}/deploy-crio:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

ARG rpm

RUN dnf install -y \
    --enablerepo=lsst-ts \
    --disablerepo=lsst-ts-test \
    MTM1M3TS-${rpm}

RUN rm -rf /opt/lsst/ts_sal/include/avro* \
    && rm -rf /opt/lsst/ts_sal/lib/libavro* /opt/lsst/ts_sal/lib/lib*kafka*

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV SAL_WORK_DIR=/opt/lsst/ts_sal/
ENV LSST_SAL_PREFIX=/opt/lsst/ts_sal/

USER saluser
WORKDIR /home/saluser/

ARG m1m3ts
ARG crio_cpp
ARG config

RUN git clone https://github.com/lsst-ts/ts_m1m3thermal

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
