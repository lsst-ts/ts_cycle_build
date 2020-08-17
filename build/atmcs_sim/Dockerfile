ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atmcs
ARG idl

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-atmcs-simulator=${atmcs} ts-idl=${idl}

LABEL ts-atmcs-simulator=${atmcs} \
      ts-idl=${idl}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
