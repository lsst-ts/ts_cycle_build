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

RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - && \
    yum install -y nodejs && node --version

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-private.repo
COPY develop-env/lsstsqre/gitconfig ${HOME}/.gitconfig

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
    chown -R ${UID}:${GID} ${HOME}/.gitconfig && \
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

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/current

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org> \
      image_tag=${lsstsqre}
