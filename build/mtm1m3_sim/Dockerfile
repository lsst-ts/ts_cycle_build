ARG cycle
ARG hub

FROM ${hub}/deploy-crio:${cycle}

LABEL maintainer="Petr Kubánek <petr.kubanek@noirlab.edu>"

WORKDIR /home/saluser/

RUN source /home/saluser/.crio_setup.sh \
    && MAKEFLAGS="-j$(nproc)" LIBSCHEMAREGISTRY_VCPKG_LIB=/opt/vcpkg/installed/x64-linux/lib salgeneratorKafka generate cpp MTM1M3 \
    && MAKEFLAGS="-j$(nproc)" LIBSCHEMAREGISTRY_VCPKG_LIB=/opt/vcpkg/installed/x64-linux/lib salgeneratorKafka generate cpp MTMount
    
ARG m1m3
ARG config

RUN git clone https://github.com/lsst-ts/ts_m1m3support

COPY mtm1m3_sim/libschemaregistry.patch /home/saluser/ts_m1m3support/

# TODO Remove the libschemaregistry patch once new m1m3support is released.
RUN source /home/saluser/.crio_setup.sh \
    && export LIBRARY_PATH="/opt/vcpkg/installed/x64-linux/lib:${LIBRARY_PATH}" \
    && cd ts_m1m3support \
    && /home/saluser/.checkout_repo.sh ${m1m3} \
    && git apply libschemaregistry.patch \
    && make -j$(nproc) simulator


USER root
COPY --chown=saluser:saluser --chmod=a+x mtm1m3_sim/startup.sh /home/saluser/.startup.sh
COPY --chown=saluser:saluser --chmod=a+x mtm1m3_sim/create_topics_mtm1m3.py /home/saluser/.create_topics_mtm1m3.py
USER saluser

ENV RUN_ARG=""
