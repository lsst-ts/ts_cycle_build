FROM centos:centos7

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG UID=73006
ARG GID=73006

ENV USER ${USER:-saluser}
ENV SALUSER_HOME /home/saluser
ENV LSST_DDS_DOMAIN=citest

USER root

RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
# COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-nexus-private.repo

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm && \
    yum install -y centos-release-scl cmake

RUN yum -y --enablerepo=extras install epel-release \
    devtoolset-8-gcc* \
    wget \
    git \
    make \
    wget \
    boost* \
    curl-devel \
    which \
    openssl-devel \
    bzip2-devel \
    libffi-devel \
    java-1.8.0-openjdk-devel \
    maven \
    zlib-devel \
    bzip2 \
    readline-devel \
    sqlite \
    sqlite-devel \
    xz \
    xz-devel \
    yum clean all

ARG dds_community_version
ARG dds_community_build
ARG dds_private_version
ARG dds_private_build

RUN touch ${SALUSER_HOME}/.ospl.env && \
    if [ -z "${dds_private_version}" ]; then \
      yum install -y OpenSpliceDDS-${dds_community_version}-${dds_community_build} ;\
      echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_community_version}/HDE/x86_64.linux" >> ${SALUSER_HOME}/.ospl.env ; \
    else \
      yum install -y --enablerepo=lsst-ts-private --disablerepo=lsst-ts \
      OpenSpliceDDS-${dds_private_version}-${dds_private_build} ; \
      echo "export OSPL_HOME=/opt/OpenSpliceDDS/V${dds_private_version}/HDE/x86_64.linux" >> ${SALUSER_HOME}/.ospl.env ; \
    fi; \
    (rm /etc/yum.repos.d/lsst-ts-nexus-private.repo || echo "No Private repo")

COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh
COPY develop-env/bare-centos/setup.sh /home/saluser/.setup.sh
COPY develop-env/bare-centos/startup.sh /home/saluser/.startup.sh

RUN chown ${UID}:${GID} /home/saluser/.checkout_repo.sh && \
    chmod a+x /home/saluser/.checkout_repo.sh && \
    chown ${UID}:${GID} /home/saluser/.setup.sh && \
    chmod a+x /home/saluser/.setup.sh && \
    chown ${UID}:${GID} /home/saluser/.ospl.env && \
    chmod a+x /home/saluser/.ospl.env && \
    ln -s /home/saluser/.pyenv/versions/3.7.6/lib/libpython3.7m.a /opt/rh/devtoolset-8/root/usr/lib64/

WORKDIR /tmp

RUN yum install -y flex && \
    curl -O http://www.maier-komor.de/xjobs/xjobs-20200726.tgz && \
    tar zxvf xjobs-20200726.tgz && \
    cd xjobs-20200726 &&\
    ./configure && \
    make && \
    make install

USER saluser

# Arguments for package versions
ARG ts_xml="develop"
ARG ts_sal="develop"

WORKDIR ${SALUSER_HOME}

RUN mkdir repos && \
    cd repos && \
    gitsrc="ts_xml:${ts_xml} \
            ts_sal:${ts_sal}" \
    rb="https://github.com/lsst-ts" && \
    for g in $gitsrc ; do \
        r=$(echo ${g} | cut -d ':' -f 1) \
        t=$(echo ${g} | cut -d ':' -f 2) ;\
        git clone ${rb}/${r}.git ; \
        cd ${r} ; \
        /home/saluser/.checkout_repo.sh ${t} ; \
        cd .. ; \
    done

RUN curl https://pyenv.run | bash &> /tmp/pyenv_output && \
    cat /tmp/pyenv_output | tail -n 6 > ${SALUSER_HOME}/.pyenv.env && \
    source ${SALUSER_HOME}/.pyenv.env && \
    pyenv install -v 3.7.6

ENV LSST_SDK_INSTALL=${SALUSER_HOME}/repos/ts_sal
ENV LSST_DDS_DOMAIN=citest

RUN mkdir -p ${SALUSER_HOME}/.empty/

WORKDIR ${SALUSER_HOME}/.empty/

LABEL ts_xml="${ts_xml}" \
      ts_sal="${ts_sal}"

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.startup.sh"]
