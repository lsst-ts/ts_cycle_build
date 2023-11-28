FROM almalinux:8

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

RUN dnf module enable -y nodejs:${node} && \
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

# Install TSSW development dependencies
USER saluser
WORKDIR /home/saluser

ARG ts_develop
ARG maven
ARG openjdk

RUN source ${WORKDIR}/loadLSST.bash && \
    conda config --add channels conda-forge && \
    conda install -y mamba

RUN source ${WORKDIR}/loadLSST.bash && \
    mamba install -y conda-build anaconda-client setuptools_scm maven=${maven} openjdk=${openjdk}

RUN source ${WORKDIR}/loadLSST.bash && \
    mamba install -y -c lsstts ts-develop=${ts_develop}

RUN source ${WORKDIR}/loadLSST.bash && \
    pip install ltd-conveyor

# Install python-gphoto2
RUN source ${WORKDIR}/loadLSST.bash && \
    pip install gphoto2==${gphoto2} --only-binary :all: && \
    pip install Pillow rawpy

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/current

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org> \
    image_tag=${lsstsqre} \
    ts_develop=${ts_develop} \
    gphoto2=${gphoto2}\
    labjack_file_version=${labjack_file_version} \
    labjack_arch=${labjack_arch} \
    labjack_ljm=${labjack_ljm}
