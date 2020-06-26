ARG deploy_tag

FROM lsstts/deploy-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atmcs
ARG idl

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atmcs-simulator=${atmcs} ts-idl=${idl}

COPY setup.sh /home/saluser/.setup.sh
