ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atmcs
ARG idl

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atmcs-simulator=${atmcs} ts-idl=${idl}

LABEL ts-atmcs-simulator=${atmcs} \
      ts-idl=${idl}

COPY setup.sh /home/saluser/.setup.sh
