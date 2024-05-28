ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atdometrajectory
ARG config

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts ts-atdometrajectory=${atdometrajectory}

RUN git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/saluser/ts_config_attcs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_ATTCS_DIR=/home/saluser/ts_config_attcs

LABEL ts-atdometrajectory=${atdometrajectory} \
      ts_config_attcs=${config}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
