ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atpneumatics_sim
ARG idl

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atpneumatics-simulator=${atpneumatics_sim} ts-idl=${idl}

LABEL ts-atpneumatics-simulator=${atpneumatics_sim} \
      ts_idl=${idl}

COPY setup.sh /home/saluser/.setup.sh
