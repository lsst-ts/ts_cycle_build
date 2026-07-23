ARG cycle
ARG hub

FROM ${hub}/deploy-crio:${cycle}

LABEL maintainer="Petr Kubánek <petr.kubanek@noirlab.edu>"

WORKDIR /home/saluser/

RUN source /home/saluser/.crio_setup.sh \
    && MAKEFLAGS="-j$(nproc)" LIBSCHEMAREGISTRY_VCPKG_LIB=/opt/vcpkg/installed/x64-linux/lib salgeneratorKafka generate cpp MTM1M3TS
    
ARG m1m3ts
ARG config

RUN git clone https://github.com/lsst-ts/ts_m1m3thermal

COPY mtm1m3ts_sim/0001-Comment-out-flow-publisher.patch /home/saluser/ts_m1m3thermal/0001-Comment-out-flow-publisher.patch
COPY mtm1m3ts_sim/m1m3ts-libschemaregistry.patch /home/saluser/ts_m1m3thermal/

# TODO Remove the m1m3ts-libschemareigstry patch once new m1m3thermal is released.
# TODO Remove the 0001-Comment-out-flow-publisher patch once m1m3thermal is released.
RUN source /home/saluser/.crio_setup.sh \
    && cd ts_m1m3thermal \
    && /home/saluser/.checkout_repo.sh ${m1m3ts} \
    && git apply 0001-Comment-out-flow-publisher.patch \
    && git apply m1m3ts-libschemaregistry.patch \
    && make -j$(nproc) simulator

USER root
COPY --chown=saluser:saluser --chmod=a+x mtm1m3ts_sim/startup.sh /home/saluser/.startup.sh
COPY --chown=saluser:saluser --chmod=a+x mtm1m3ts_sim/create_topics_mtm1m3ts.py /home/saluser/.create_topics_mtm1m3ts.py
USER saluser

ENV RUN_ARG=""
