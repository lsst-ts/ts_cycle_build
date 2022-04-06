ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Petr Kubánek <pkubanek@lsst.org>

ARG ts_mtaircompressor

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-mtaircompressor=${ts_mtaircompressor}

WORKDIR /home/saluser/

ENV TS_CONFIG_EAS_DIR=/home/saluser/ts_config_eas
ENV RUN_ARG=""

LABEL ts-mtaircompressor=${ts_mtaircompressor}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
