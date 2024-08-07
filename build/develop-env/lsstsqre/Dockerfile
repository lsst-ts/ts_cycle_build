FROM almalinux:9

ARG UID=73006
ARG GID=73006

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
ENV WORKDIR /opt/lsst/software/stack

USER root

RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-private.repo
COPY develop-env/lsstsqre/gitconfig ${HOME}/.gitconfig
COPY develop-env/lsstsqre/setup_env.sh /home/saluser/.setup_salobj.sh

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
    qt5-qtbase-devel \
    mesa-dri-drivers \
    xorg-x11-server-Xvfb

# Install Yarn package manager
RUN npm install --global yarn
RUN chown -R ${UID}:${GID} ${HOME}/.npm

ARG dds_community_version=6.9.0
ARG dds_community_build=1.el6
ARG dds_private_version
ARG dds_private_build

RUN mkdir -p ${WORKDIR} && \
    touch ${WORKDIR}/ospl.env && \
    chown -R ${UID}:${GID} ${HOME}/.gitconfig && \
    chown -R ${UID}:${GID} ${WORKDIR}/ && \
    chmod a+x ${WORKDIR}/ospl.env && \
    chown ${UID}:${GID} /home/saluser/.setup_salobj.sh && \
    chmod a+x /home/saluser/.setup_salobj.sh && \
    if [ -z "${dds_private_version}" ]; then \
    dnf install -y OpenSpliceDDS-${dds_community_version}-${dds_community_build} ; \
    echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl.env ; \
    else \
    dnf install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
    OpenSpliceDDS-${dds_private_version}-${dds_private_build} ; \
    echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_private_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl.env ; \
    fi

RUN rm /etc/yum.repos.d/lsst-ts-private.repo

WORKDIR /usr/share/zoneinfo

RUN curl -O ftp://ftp.boulder.nist.gov/pub/time/leap-seconds.list

ARG gphoto2=${gphoto2}

# Install DM stack using lsstinstall
USER saluser

WORKDIR ${WORKDIR}

ARG stack

RUN curl -LO https://ls.st/lsstinstall && \
    bash lsstinstall -T ${stack}

RUN source ./loadLSST.bash && \
    eups distrib install -t ${stack} lsst_distrib

# Install labjack
USER root
WORKDIR /tmp
ARG labjack_file_version
ARG labjack_arch
ARG labjack_ljm
COPY common/install_labjack.sh /tmp/install_labjack.sh
RUN chmod +x /tmp/install_labjack.sh && \
    /tmp/install_labjack.sh --labjack_file_version=${labjack_file_version} \
    --labjack_arch=${labjack_arch} --labjack_ljm=${labjack_ljm} \
    --saluser_env_script="/opt/lsst/software/stack/loadLSST.bash"

ARG maven
ARG openjdk

# Install Azul
RUN dnf install -y https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm && \
    dnf install -y zulu${openjdk}-jdk

ENV WORKDIR /usr/lib/maven

RUN mkdir ${WORKDIR} && \
    curl -LO https://archive.apache.org/dist/maven/maven-3/${maven}/binaries/apache-maven-${maven}-bin.tar.gz && \
    tar zxf apache-maven-${maven}-bin.tar.gz

# Install TSSW development dependencies
ENV WORKDIR /opt/lsst/software/stack
USER saluser
WORKDIR /home/saluser

ARG ts_develop

RUN source ${WORKDIR}/loadLSST.bash && \
    conda config --add channels conda-forge && \
    conda config --set solver libmamba

RUN source ${WORKDIR}/loadLSST.bash && \
    conda install -y conda-build anaconda-client setuptools_scm

RUN source ${WORKDIR}/loadLSST.bash && \
    conda install -y -c lsstts ts-develop=${ts_develop}

RUN source ${WORKDIR}/loadLSST.bash && \
    conda install -y ltd-conveyor

# Install python-gphoto2
RUN source ${WORKDIR}/loadLSST.bash && \
    pip install gphoto2==${gphoto2} --no-deps --only-binary :all: && \
    pip install --no-deps rawpy==0.21 

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/current
ENV JAVA_HOME=/usr/lib/jvm/zulu${openjdk}
ENV MAVEN_HOME=/usr/lib/maven/apache-maven-${maven}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org> \
    image_tag=${lsstsqre} \
    ts_develop=${ts_develop} \
    gphoto2=${gphoto2}\
    labjack_file_version=${labjack_file_version} \
    labjack_arch=${labjack_arch} \
    labjack_ljm=${labjack_ljm}
