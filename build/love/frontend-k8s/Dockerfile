from alpine/git as cloner

WORKDIR /usr/src/love
ARG love_frontend
RUN git clone --branch ${love_frontend} --depth 1 --single-branch https://github.com/lsst-ts/LOVE-frontend || git clone --branch v${love_frontend} --depth 1 --single-branch https://github.com/lsst-ts/LOVE-frontend

FROM node:16.13.2-alpine as builder

COPY --from=cloner /usr/src/love/LOVE-frontend /usr/src/love/LOVE-frontend

WORKDIR /usr/src/love/LOVE-frontend/love

# Install and cache app dependencies
RUN yarn install

# Set environment variables for build
RUN echo "PUBLIC_URL=/love" > .env

# Build static files
RUN yarn build

# copy compiled files to smaller image
FROM alpine:3.8
COPY --from=builder /usr/src/love/LOVE-frontend/love/build /usr/src/love
COPY --from=builder /usr/src/love/LOVE-frontend/love/build /usr/src/love-build
VOLUME /usr/src/love
