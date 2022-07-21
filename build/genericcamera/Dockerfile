ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ARG genericcamera
ARG config
ARG gphoto2

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

WORKDIR /home/saluser/ts_config_ocs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV RUN_ARG=""

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER saluser

RUN source /home/saluser/.setup_sal_env.sh && \
    pip install gphoto2==${gphoto2} --only-binary :all: && \
    pip install Pillow rawpy

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -y -c lsstts ts-genericcamera=${genericcamera}

LABEL ts-genericcamera=${genericcamera} \
      ts_config_ocs=${config}
