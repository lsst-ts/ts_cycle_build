ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Sebastian Aranda <saranda@lsst.org>

WORKDIR /home/saluser/

ARG ts_logging_frontend

RUN git clone --branch ${ts_logging_frontend} --depth 1 --single-branch https://github.com/lsst-ts/ts_logging_frontend.git || git clone --branch v${ts_logging_frontend} --depth 1 --single-branch https://github.com/lsst-ts/ts_logging_frontend.git

WORKDIR /home/saluser/ts_logging_frontend

RUN npm install
RUN npx vite build

USER saluser
VOLUME /home/saluser/ts_logging_frontend/dist
