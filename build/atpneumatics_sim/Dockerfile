ARG deploy_tag

FROM lsstts/deploy-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atpneumatics_sim
ARG idl

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atpneumatics-simulator=${atpneumatics_sim} ts-idl=${idl}

COPY setup.sh /home/saluser/.setup.sh
