ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Sebastian Aranda <saranda@lsst.org>

WORKDIR /home/saluser/

ARG ts_logging_and_reporting

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts \
    ts-logging-and-reporting=${ts_logging_and_reporting}


# Workaround until we lsst-resources get conda packaged.
# See: OSW-1382.
RUN source /home/saluser/.setup_sal_env.sh && \
    pip install lsst-resources

WORKDIR /home/saluser/

LABEL ts_logging_and_reporting=${ts_logging_and_reporting}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
