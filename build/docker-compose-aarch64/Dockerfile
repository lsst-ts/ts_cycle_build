FROM almalinux:8

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ENV HOME /root

RUN dnf install -y epel-release && \
    dnf install -y dnf-plugin-config-manager && \
    dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf install -y docker-ce docker-ce-cli containerd.io wget && \
    wget -q https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-aarch64 -O /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

ENTRYPOINT ["/bin/bash", "--"]
