FROM almalinux:9

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ENV HOME /root

RUN dnf install -y epel-release && \
    dnf install -y dnf-plugin-config-manager && \
    dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf install -y docker-ce docker-ce-cli containerd.io wget

ENTRYPOINT ["/bin/bash", "--"]
