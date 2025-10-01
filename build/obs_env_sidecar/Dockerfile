# Clone repo
FROM alpine/git as cloner

WORKDIR /usr/src/

RUN git clone https://github.com/lsst-ts/ts_manage_observing_environment.git && \
    cd ts_manage_observing_environment && \ 
    git checkout feature/sidecar

# Build 
FROM rust:1.85.1 as builder

RUN apt update && \
    apt install -y libsasl2-dev cmake

WORKDIR /usr/src/

COPY --from=cloner /usr/src/ts_manage_observing_environment /usr/src/ts_manage_observing_environment

WORKDIR /usr/src/ts_manage_observing_environment
RUN cargo build -r --bin obs_env_sidecar

# Deployment image
FROM debian:bookworm-slim

RUN apt-get update
RUN apt-get install -y ca-certificates libsasl2-dev

COPY --from=builder /usr/src/ts_manage_observing_environment/target/release/obs_env_sidecar /usr/local/bin/obs_env_sidecar

RUN mkdir -p /net/obs-env/auto_base_packages

CMD ["obs_env_sidecar"]
