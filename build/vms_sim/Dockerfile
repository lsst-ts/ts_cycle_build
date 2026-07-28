ARG cycle
ARG hub

FROM ${hub}/deploy-crio:${cycle}

LABEL maintainer="Petr Kubánek <petr.kubanek@noirlab.edu>"

WORKDIR /home/saluser/

RUN source /home/saluser/.crio_setup.sh \
    && MAKEFLAGS="-j$(nproc)" LIBSCHEMAREGISTRY_VCPKG_LIB=/opt/vcpkg/installed/x64-linux/lib salgeneratorKafka generate cpp MTVMS

RUN source /home/saluser/.setup_sal_env.sh \
    && mamba install -y fftw
    
ARG vms

RUN git clone https://github.com/lsst-ts/ts_vms

COPY vms_sim/vms-libschemaregistry.patch /home/saluser/ts_vms/

# TODO remove vms-libschemaregistry.patch once new vms is released.
RUN source /home/saluser/.crio_setup.sh \
    && cd ts_vms \
    && /home/saluser/.checkout_repo.sh ${vms} \
    && git apply vms-libschemaregistry.patch \
    && make -j$(nproc) simulator

COPY --chown=saluser:saluser --chmod=a+x vms_sim/startup.sh /home/saluser/.startup.sh
RUN chmod 755 /home/saluser/.startup.sh
COPY --chown=saluser:saluser --chmod=a+x vms_sim/create_topics_vms.py /home/saluser/.create_topics_vms.py

ENV RUN_ARG=""
