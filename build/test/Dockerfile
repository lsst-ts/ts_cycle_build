ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG idl=1.1.3_4.8.0

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-idl=${idl}

# RUN mkdir /home/saluser/miniconda3/lib/python3.7/schema/

# WORKDIR /home/saluser/miniconda3/lib/python3.7/schema/

# RUN wget https://raw.githubusercontent.com/lsst-ts/ts_salobj/develop/schema/Test.yaml

WORKDIR /home/saluser/
RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV RUN_ARG=1
ENV OSPL_MASTER_PRIORITY=200
COPY setup.sh /home/saluser/.setup.sh

COPY run_testing.py /home/saluser/run_testing.py
USER root

RUN chown saluser:saluser /home/saluser/run_testing.py && \
    chown saluser:saluser /home/saluser/.setup.sh && \
    chmod a+x /home/saluser/run_testing.py && \
    chmod a+x /home/saluser/.setup.sh

USER saluser
