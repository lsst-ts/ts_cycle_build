FROM almalinux:8

USER root

SHELL ["/bin/bash", "-lc"]

ENV STACKDIR /opt/lsst/software/stack

WORKDIR ${STACKDIR}

ENV QT_API="PySide6"
ENV PYTEST_QT_API="PySide6"

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo

ARG  java_v
ARG  osplice_v
ARG  osplice_build
ARG  osplice_py

RUN dnf install -y --enablerepo=extras \
    dos2unix \
    iproute \
    iptables \
    libmnl \
    libnfnetlink \
    libnetfilter_conntrack \
    "java-${java_v}-openjdk-devel" \
    "OpenSpliceDDS-${osplice_v}-${osplice_build}"

ENV OSPL_HOME=/opt/OpenSpliceDDS/V${osplice_v}/HDE/x86_64.linux
ENV osplice_v=${osplice_v}
ENV osplice_build=${osplice_build}
ENV osplice_py=${osplice_py}

RUN groupadd --gid 1000 lsst && \
    adduser -u 1000 -m -g 1000 -s /bin/bash lsst

RUN chown -R lsst:lsst ${STACKDIR}

USER lsst

ARG stack

RUN curl -LO https://ls.st/lsstinstall && \
    bash lsstinstall -T ${stack}

RUN source ./loadLSST.bash && \
    eups distrib install -t ${stack} lsst_distrib && \
    eups distrib install -t ${stack} lsst_sitcom

