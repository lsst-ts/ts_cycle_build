ARG image_tag

FROM lsstsqre/centos:${image_tag}

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
ENV WORKDIR /opt/lsst/software/stack

USER root

ARG UID=1000
ARG GID=1000

# Create user and group
RUN if [ $UID -eq 1000 ] && [ $GID -eq 1000 ]; then  \
    echo "Renaming lsst to saluser" && \
    usermod -l saluser lsst && \
    usermod -d /home/saluser -m saluser ; \
    else \
    groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser && \
    usermod -a -G lsst saluser ; \
    fi

RUN curl -sL https://rpm.nodesource.com/setup_current.x | bash - && \
    yum install -y nodejs && node --version

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-private.repo
COPY develop-env/lsstsqre/gitconfig ${HOME}/.gitconfig
COPY develop-env/lsstsqre/setup_env.sh /home/saluser/.setup_salobj.sh

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm
RUN RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash 
RUN yum -y --enablerepo=extras install epel-release \
    unzip \
    wget \
    git \
    git-lfs \
    dos2unix \
    tk \
    tk-devel \
    swig \
    ncurses-libs \
    xterm \
    xorg-x11-fonts-misc \
    java-1.8.0-openjdk-devel \
    maven \
    which \
    gnome-terminal \
    mariadb \
    mariadb-devel \
    nano \
    emacs \
    ifconfig \
    gdb \
    ltrace\
    strace \
    net-tools \
    ntp \
    tcpdump \
    graphviz* \
    tzdata \
    make \
    libtool-ltdl-devel \
    libtool \
    automake \
    libusb-devel \
    popt-devel \
    gettext-devel \
    libexif-devel \
    LibRaw-devel \
    bzip2 \
    file

ARG dds_community_version=6.9.0
ARG dds_community_build=1.el6
ARG dds_private_version
ARG dds_private_build

RUN touch ${WORKDIR}/ospl.env && \
    chown -R ${UID}:${GID} ${HOME}/.gitconfig && \
    chown -R ${UID}:${GID} ${WORKDIR}/ospl.env && \
    chmod a+x ${WORKDIR}/ospl.env && \
    chown ${UID}:${GID} /home/saluser/.setup_salobj.sh && \
    chmod a+x /home/saluser/.setup_salobj.sh && \
    if [ -z "${dds_private_version}" ]; then \
    yum install -y OpenSpliceDDS-${dds_community_version}-${dds_community_build} ; \
    echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl.env ; \
    else \
    yum install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
    OpenSpliceDDS-${dds_private_version}-${dds_private_build} ; \
    echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_private_version}/HDE/x86_64.linux" >> ${WORKDIR}/ospl.env ; \
    fi

RUN rm /etc/yum.repos.d/lsst-ts-private.repo

RUN yum clean all

WORKDIR /usr/share/zoneinfo

RUN wget http://www.ietf.org/timezones/data/leap-seconds.list

ARG gphoto2=${gphoto2}

# Install GPhoto2
WORKDIR /tmp
RUN curl -sSL https://github.com/gphoto/libgphoto2/releases/download/v${gphoto2}/libgphoto2-${gphoto2}.tar.bz2 -o libgphoto2-${gphoto2}.tar.bz2 && \
    tar jxf libgphoto2-${gphoto2}.tar.bz2 && \
    cd libgphoto2-${gphoto2} && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install && \
    # Copy the .pc files so pkg-config can find them later on
    cp libgphoto2.pc /usr/share/pkgconfig && \
    cp libgphoto2_port/libgphoto2_port.pc /usr/share/pkgconfig && \
    echo "/usr/local/lib" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2/${gphoto2}" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2_port/0.12.0" >> /etc/ld.so.conf.d/gphoto2.conf && \
    ldconfig

# Install LibGPhoto2
WORKDIR /tmp
RUN curl -sSL https://github.com/gphoto/gphoto2/releases/download/v${gphoto2}/gphoto2-${gphoto2}.tar.bz2 -o gphoto2-${gphoto2}.tar.bz2 && \
    tar jxf gphoto2-${gphoto2}.tar.bz2 && \
    cd gphoto2-${gphoto2} && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install

USER saluser

WORKDIR /home/saluser

ARG ts_develop

RUN source ${WORKDIR}/loadLSST.bash && \
    conda install -y -c lsstts ts-develop=${ts_develop}

RUN source ${WORKDIR}/loadLSST.bash && \
    pip install "documenteer[pipelines]>=0.6" ltd-conveyor kafkit[aiohttp] confluent_kafka

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    conda install -y jupyterlab

#     jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
#     jupyter labextension install jupyter-matplotlib && \
#     jupyter notebook --generate-config

# Needed for Python-GPhoto2
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    pip install Pillow rawpy

# Install Python-GPhoto2
WORKDIR /tmp
RUN source /home/saluser/.setup_salobj.sh && \
    git clone https://github.com/jim-easterbrook/python-gphoto2.git && \
    cd python-gphoto2 && \
    python developer/build_swig.py system && \
    python setup.py build && \
    python setup.py install

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/current

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org> \
    image_tag=${lsstsqre}
