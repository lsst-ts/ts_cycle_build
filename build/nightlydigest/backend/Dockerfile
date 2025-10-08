ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Sebastian Aranda <saranda@lsst.org>

WORKDIR /home/saluser/

ARG ts_logging_and_reporting
ARG rubin_nights_tag

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts \
    ts-logging-and-reporting=${ts_logging_and_reporting}

# Temporary workaround to install rubin_nights until it is available via conda
RUN source /home/saluser/.setup_sal_env.sh && \
    pip install --upgrade git+https://github.com/lsst-sims/rubin_nights.git@v${rubin_nights_tag}

WORKDIR /home/saluser/

LABEL ts_logging_and_reporting=${ts_logging_and_reporting}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
