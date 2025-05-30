FROM almalinux:9

ARG UID=73006
ARG GID=73006

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
ENV STACKDIR /opt/lsst/software/stack
ENV WORKDIR ${STACKDIR}

USER root

RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-private.repo
COPY develop-env/lsstsqre/gitconfig ${HOME}/.gitconfig
COPY develop-env/lsstsqre/setup_env.sh /home/saluser/.setup_salobj.sh

RUN if [ -d "$HOME/.cache" ]; then \
    chown -R saluser:saluser "$HOME/.cache"; \
    fi

ARG node

RUN dnf install -y yum-utils && \
    dnf module enable -y nodejs:${node} && \
    dnf config-manager --set-enabled crb && \
    dnf install -y \
    automake \
    bzip2 \
    diffutils \
    dos2unix \
    emacs \
    file \
    gdb \
    gettext-devel \
    git \
    git-lfs \
    glibc-devel \
    gnome-terminal \
    graphviz* \
    iproute \
    libexif \
    LibRaw \
    libtool \
    libtool-ltdl-devel \
    libusbx-devel \
    ltrace\
    make \
    mariadb \
    mariadb-devel \
    nano \
    ncurses-libs \
    net-tools \
    net-tools \
    nodejs \
    popt-devel \
    strace \
    swig \
    tcpdump \
    tk \
    tk-devel \
    tzdata \
    unzip \
    wget \
    which \
    xorg-x11-fonts-misc \
    xterm \
    epel-release \
    freeglut-devel \
    mesa-dri-drivers \
    xorg-x11-server-Xvfb

# Install Yarn package manager
RUN npm install --global yarn
RUN chown -R ${UID}:${GID} ${HOME}/.npm

# DDS Plumbing, remove if not needed for whatever reason.

# ARG dds_community_version=6.9.0
# ARG dds_community_build=1.el6
# ARG dds_private_version
# ARG dds_private_build

# RUN mkdir -p ${WORKDIR} && \
#     touch ${WORKDIR}/ospl.env && \
#     chown -R ${UID}:${GID} ${HOME}/.gitconfig && \
#     chown -R ${UID}:${GID} ${WORKDIR}/ && \
#     chmod a+x ${WORKDIR}/ospl.env && \
#     chown ${UID}:${GID} /home/saluser/.setup_salobj.sh && \
#     chmod a+x /home/saluser/.setup_salobj.sh && \
#     if [ -z "${dds_private_version}" ]; then \
#     dnf install -y OpenSpliceDDS-${dds_community_version}-${dds_community_build} ; \
#     echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl.env ; \
#     else \
#     dnf install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
#     OpenSpliceDDS-${dds_private_version}-${dds_private_build} ; \
#     echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_private_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl.env ; \
#     fi

RUN if [ -f "${HOME}/.cache" ]; then \
      chown -R "${UID}:${GID}" "${HOME}/.cache"; \
    fi

RUN rm /etc/yum.repos.d/lsst-ts-private.repo

WORKDIR /usr/share/zoneinfo

RUN curl -O ftp://ftp.boulder.nist.gov/pub/time/leap-seconds.list

ARG gphoto2=${gphoto2}

# Install DM stack using lsstinstall
USER saluser

WORKDIR ${STACKDIR}

ARG stack

RUN curl -LO https://ls.st/lsstinstall && \
    bash lsstinstall -T ${stack}

RUN source ./loadLSST.bash && \
    eups distrib install -t ${stack} lsst_distrib

# Install labjack
USER root
ENV WORKDIR /tmp
ARG labjack_file_version
ARG labjack_arch
ARG labjack_ljm
COPY common/install_labjack.sh /tmp/install_labjack.sh
RUN chown -R ${UID}:${GID} ${HOME}/.cache; \
    chmod +x /tmp/install_labjack.sh && \
    /tmp/install_labjack.sh --labjack_file_version=${labjack_file_version} \
    --labjack_arch=${labjack_arch} --labjack_ljm=${labjack_ljm} \
    --saluser_env_script="/opt/lsst/software/stack/loadLSST.bash"

ARG maven
ARG openjdk

# Install Azul
RUN dnf install -y https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm && \
    dnf install -y zulu${openjdk}-jdk

ENV WORKDIR /usr/lib/maven
WORKDIR /usr/lib/maven

RUN curl -LO https://archive.apache.org/dist/maven/maven-3/${maven}/binaries/apache-maven-${maven}-bin.tar.gz && \
    tar zxf apache-maven-${maven}-bin.tar.gz

# Install TSSW development dependencies
USER saluser
WORKDIR /home/saluser

ARG ts_develop
ARG librdkafka
ARG python_confluent_kafka

RUN source ${STACKDIR}/loadLSST.bash && \
    conda config --add channels conda-forge && \
    conda config --set solver libmamba

RUN source ${STACKDIR}/loadLSST.bash && \
    conda install -y conda-build anaconda-client setuptools_scm

RUN source ${STACKDIR}/loadLSST.bash && \
    conda install -y -c lsstts ts-develop=${ts_develop}

# Workaround for pin on python-confluent-kafka.
RUN sed -i 's/    "python-confluent-kafka >=1.9.2,<2",/    "python-confluent-kafka >=1.9.2",/' ${STACKDIR}/conda/envs/lsst-scipipe-9.0.0/conda-meta/rubin-env-nosysroot* && \
    sed -i 's/    "python-confluent-kafka 1.9.*",/    "python-confluent-kafka >=1.9.2",/' ${STACKDIR}/conda/envs/lsst-scipipe-9.0.0/conda-meta/ts-develop* && \
    sed -i 's/    "aiohttp 3.9.*",/    "aiohttp >=3.9.*",/' ${STACKDIR}/conda/envs/lsst-scipipe-9.0.0/conda-meta/ts-develop* || echo "Warning: Failed to update pin on python-confluent-kafka."

RUN source ${STACKDIR}/loadLSST.bash && \
    conda install -y librdkafka=${librdkafka} python-confluent-kafka=${python_confluent_kafka}

# Temporary workaround for aiohttp until we move to rubin-env 10.
RUN source ${STACKDIR}/loadLSST.bash && \
    conda install -y aiohttp=3.11

RUN source ${STACKDIR}/loadLSST.bash && \
    conda install -y ltd-conveyor

# Install python-gphoto2
RUN source ${STACKDIR}/loadLSST.bash && \
    pip install gphoto2==${gphoto2} --no-deps --only-binary :all: && \
    pip install --no-deps rawpy==0.24

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/current
ENV JAVA_HOME=/usr/lib/jvm/zulu${openjdk}
ENV MAVEN_HOME=/usr/lib/maven/apache-maven-${maven}
ENV PATH=${PATH}:${MAVEN_HOME}/bin

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org> \
    image_tag=${lsstsqre} \
    ts_develop=${ts_develop} \
    gphoto2=${gphoto2}\
    labjack_file_version=${labjack_file_version} \
    labjack_arch=${labjack_arch} \
    labjack_ljm=${labjack_ljm}
