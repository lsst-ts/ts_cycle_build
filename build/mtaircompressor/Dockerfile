ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Petr Kubánek <pkubanek@lsst.org>

ARG ts_mtaircompressor

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts ts-mtaircompressor=${ts_mtaircompressor}

RUN git clone https://github.com/lsst-ts/ts_config_mttcs.git

WORKDIR /home/saluser/ts_config_mttcs

ARG config
RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_MTTCS_DIR=/home/saluser/ts_config_mttcs
ENV RUN_ARG=""

LABEL ts-mtaircompressor=${ts_mtaircompressor} \
      ts_config_mttcs=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
