ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Sebastian Aranda <saranda@lsst.org>

WORKDIR /home/saluser/

ARG ts_nightreport

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -c lsstts \
    ts-nightreport=${ts_nightreport}

# Handle alembic migrations files
RUN git clone https://github.com/lsst-ts/ts_nightreport
WORKDIR /home/saluser/ts_nightreport
RUN git checkout v${ts_nightreport}
WORKDIR /home/saluser/
RUN cp -R /home/saluser/ts_nightreport/alembic /home/saluser/alembic
RUN cp /home/saluser/ts_nightreport/alembic.ini /home/saluser/alembic.ini

LABEL ts_nightreport=${ts_nightreport}

COPY startup.sh /home/saluser/.startup.sh 
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
