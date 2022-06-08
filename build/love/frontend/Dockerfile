# Clone repo
FROM alpine/git as cloner

WORKDIR /usr/src/love
ARG love_frontend
RUN git clone --branch ${love_frontend} --depth 1 --single-branch https://github.com/lsst-ts/LOVE-frontend.git || git clone --branch v${love_frontend} --depth 1 --single-branch https://github.com/lsst-ts/LOVE-frontend.git

# Build artifacts
FROM node:lts as builder
COPY --from=cloner /usr/src/love/LOVE-frontend /usr/src/love/LOVE-frontend
WORKDIR /usr/src/love/LOVE-frontend/love
RUN yarn install && yarn build

# Copy artifacts files to smaller image
FROM alpine:3.8
COPY --from=builder /usr/src/love/LOVE-frontend/love/build /usr/src/love
COPY --from=builder /usr/src/love/LOVE-frontend/love/build /usr/src/love-build
VOLUME /usr/src/love

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>
LABEL love_frontend=${love_frontend}
