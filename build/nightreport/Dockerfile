ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Sebastian Aranda <saranda@lsst.org>

WORKDIR /home/saluser/

ARG ts_nightreport

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts \
    ts-nightreport=${ts_nightreport}

# Handle alembic migrations files
RUN git clone https://github.com/lsst-ts/ts_nightreport
WORKDIR /home/saluser/ts_nightreport
RUN if echo ${ts_nightreport} | grep -q "a"; then \
        tag_version=$(echo ${ts_nightreport} | sed -E 's/([0-9]+\.[0-9]+\.[0-9]+)a([0-9]+)/\1-alpha.\2/'); \
    elif echo ${ts_nightreport} | grep -q "rc"; then \
        tag_version=$(echo ${ts_nightreport} | sed -E 's/([0-9]+\.[0-9]+\.[0-9]+)rc([0-9]+)/\1-rc.\2/'); \
    else \
        tag_version=${ts_nightreport}; \
    fi && \
    git checkout v$tag_version
WORKDIR /home/saluser/
RUN cp -R /home/saluser/ts_nightreport/alembic /home/saluser/alembic
RUN cp /home/saluser/ts_nightreport/alembic.ini /home/saluser/alembic.ini

LABEL ts_nightreport=${ts_nightreport}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
