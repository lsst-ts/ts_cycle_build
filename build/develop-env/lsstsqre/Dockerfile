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
         chown ${UID}:${GID} -R /opt/lsst/ ; \
    fi

RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - && \
    yum install -y nodejs && node --version

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-private.repo

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm

RUN yum -y --enablerepo=extras install epel-release \
  unzip \
  wget \
  git \
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
  libgphoto2-devel

ARG dds_community_version=6.9.0
ARG dds_community_build=1.el6
ARG dds_private_version
ARG dds_private_build

RUN touch ${WORKDIR}/ospl.env && \
    chown -R ${UID}:${GID} ${WORKDIR}/ospl.env && \
    chmod a+x ${WORKDIR}/ospl.env && \
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

USER saluser

WORKDIR /home/saluser

RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl.env && \
    source ${OSPL_HOME}/release.com && \
    conda list --explicit > spec_file.txt && \
    conda create -n $LSST_CONDA_ENV_NAME -y python=3.7.6 && \
    conda install -y --file spec_file.txt

RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl.env && \
    conda install -y --force-reinstall ld_impl_linux-64 && \
    conda install -y -c conda-forge kafkacat pyqt fontconfig gxx_linux-64 cmake

RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl.env && \
    pip install jupyterlab "documenteer[pipelines]==0.5.8" "kafkit[aiohttp]" \
    aiokafka confluent_kafka asynccmd aiounittest ipdb wget pytest-subtests \
    pycodestyle aiomisc ipympl ginga pyevents jinja2 ephem gitpython \
    sqlalchemy asynctest lxml pytest-asyncio astroquery ltd-conveyor \
    moto boto3 black==19.10b0

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    jupyter labextension install jupyter-matplotlib && \
    jupyter notebook --generate-config

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/current

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org> \
      image_tag=${lsstsqre}
