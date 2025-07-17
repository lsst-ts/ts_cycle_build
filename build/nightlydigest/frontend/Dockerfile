from alpine/git as cloner
LABEL maintainer Sebastian Aranda <saranda@lsst.org>

WORKDIR /usr/src/app

# Accept build arguments
ARG VITE_EXTERNAL_INSTANCE_URL
# Set as environment variables for the build process
ENV VITE_EXTERNAL_INSTANCE_URL=${VITE_EXTERNAL_INSTANCE_URL}

ARG ts_logging_frontend

RUN git clone --branch ${ts_logging_frontend} --depth 1 --single-branch https://github.com/lsst-ts/ts_logging_frontend.git || git clone --branch v${ts_logging_frontend} --depth 1 --single-branch https://github.com/lsst-ts/ts_logging_frontend.git

FROM node:23-alpine as builder

COPY --from=cloner /usr/src/app/ts_logging_frontend /usr/src/app

WORKDIR /usr/src/app

RUN npm install
RUN npx vite build

VOLUME /usr/src/app/dist
