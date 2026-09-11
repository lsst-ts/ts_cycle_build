FROM almalinux:9

ARG UID=73006
ARG GID=73006

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
ENV STACKDIR /opt/lsst/software/stack
ENV WORKDIR ${STACKDIR}

USER root

RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser
    
RUN dnf install -y yum-utils && dnf config-manager --set-enabled crb && dnf install -y git git-lfs make wget pkg-config libgphoto2-devel gcc xorg-x11-server-Xvfb
    
# RUN dnf install -y yum-utils && \
#     dnf config-manager --set-enabled crb && \
#     dnf install -y \
#     automake \
#     bzip2 \
#     diffutils \
#     dos2unix \
#     emacs \
#     file \
#     gdb \
#     gettext-devel \
#     git \
#     git-lfs \
#     glibc-devel \
#     gnome-terminal \
#     graphviz* \
#     iproute \
#     libexif \
#     LibRaw \
#     libtool \
#     libtool-ltdl-devel \
#     libusbx-devel \
#     ltrace\
#     make \
#     mariadb \
#     mariadb-devel \
#     nano \
#     ncurses-libs \
#     net-tools \
#     net-tools \
#     popt-devel \
#     strace \
#     swig \
#     tcpdump \
#     tk \
#     tk-devel \
#     tzdata \
#     unzip \
#     wget \
#     which \
#     xorg-x11-fonts-misc \
#     xterm \
#     epel-release \
#     freeglut-devel \
#     mesa-dri-drivers \
#     xorg-x11-server-Xvfb

COPY --from=common lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY --from=common lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-private.repo
COPY --from=lsstsqre gitconfig ${HOME}/.gitconfig
COPY --from=common install_labjack.sh /tmp/install_labjack.sh
COPY checkout_repo.sh ${HOME}/.checkout_repo.sh
COPY setup-ts-environment.sh ${HOME}/.setup_ts_environment.sh

ARG python_version

RUN if [ -d "$HOME/.cache" ]; then \
    chown -R saluser:saluser "$HOME/.cache"; \
    fi

RUN rm /etc/yum.repos.d/lsst-ts-private.repo

WORKDIR /usr/share/zoneinfo

RUN curl -O ftp://ftp.boulder.nist.gov/pub/time/leap-seconds.list

ARG gphoto2=${gphoto2}

# Install DM stack using lsstinstall
USER saluser

# WORKDIR ${STACKDIR}

# ARG stack

# RUN curl -LO https://ls.st/lsstinstall && \
#     bash lsstinstall -T ${stack}

# RUN source ./loadLSST.bash && \
#     eups distrib install -t ${stack} lsst_distrib

ARG prefix="ssw"
ENV ENVNAME=${prefix}-${python_version}

USER root
RUN mkdir -p /opt/lsst/software/stack
RUN chown -R saluser /opt/lsst/
USER saluser
WORKDIR ${HOME}
RUN wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && bash Miniforge3.sh -b -p "${STACKDIR}/conda" && source "/opt/lsst/software/stack/conda/etc/profile.d/conda.sh" && source "/opt/lsst/software/stack/conda/etc/profile.d/mamba.sh" && conda init
ENV PATH=${STACKDIR}/conda/bin:${PATH}
RUN conda config --add channels lsstts && conda create -n ${ENVNAME} python=${python_version} ts-develop=0.6
RUN conda create -n ssw-3.14 python=3.14 ts-develop=0.6

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Install labjack
USER root
ENV WORKDIR /tmp
ARG labjack_file_version
ARG labjack_arch
ARG labjack_ljm

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

RUN conda install -n ${ENVNAME} -y ltd-conveyor

# Install python-gphoto2
RUN LDFLAGS="-L/usr/lib64 ${LDFLAGS}" \
    LIBRARY_PATH="/usr/lib64:${LIBRARY_PATH}" \
    conda run -n ${ENVNAME} uv pip install gphoto2==${gphoto2} --no-deps && \
    conda run -n ${ENVNAME} uv pip install --no-deps rawpy==0.24
    
ENV TSSW_PATH=/opt/lsst/tssw

USER root
RUN mkdir ${TSSW_PATH} && \
    chown saluser:saluser ${TSSW_PATH}

USER saluser

RUN ln -s ${TSSW_PATH} /home/saluser/repos

ARG ts_config_ocs="develop"
ARG ts_config_attcs="develop"
ARG ts_config_mtcalsys="develop"
ARG ts_config_eas="develop"
ARG ts_config_latiss="develop"
ARG ts_config_mttcs="develop"
ARG ts_config_atcalsys="develop"
ARG ts_xml="develop"
ARG ts_idl="develop"
ARG ts_sal="develop"
ARG ts_utils="develop"
ARG ts_salobj="develop"
ARG ts_scriptqueue="develop"
ARG ts_observatory_control="develop"
ARG ts_standardscripts="develop"
ARG ts_auxtel_standardscripts="develop"
ARG ts_maintel_standardscripts="develop"
ARG ts_externalscripts="develop"
ARG ts_atmcs="develop"
ARG ts_atdome="develop"
ARG ts_atdometrajectory="develop"
ARG ts_attcpip="develop"
ARG ts_simactuators="develop"
ARG ts_hexrotcomm="develop"
ARG ts_tcpip="develop"
ARG ts_criopy="develop"
ARG ts_m1m3_utils="develop"
ARG ts_planning_tool="develop"

USER root
RUN chmod +x ${HOME}/.checkout_repo.sh ${HOME}/.setup_ts_environment.sh
USER saluser

RUN ts_config_ocs=${ts_config_ocs} \
    ts_config_attcs=${ts_config_attcs} \
    ts_config_mtcalsys=${ts_config_mtcalsys} \
    ts_config_eas=${ts_config_eas} \
    ts_config_latiss=${ts_config_latiss} \
    ts_config_mttcs=${ts_config_mttcs} \
    ts_config_atcalsys=${ts_config_atcalsys} \
    ts_xml=${ts_xml} \
    ts_idl=${ts_idl} \
    ts_sal=${ts_sal} \
    ts_utils=${ts_utils} \
    ts_salobj=${ts_salobj} \
    ts_scriptqueue=${ts_scriptqueue} \
    ts_observatory_control=${ts_observatory_control} \
    ts_standardscripts=${ts_standardscripts} \
    ts_auxtel_standardscripts=${ts_auxtel_standardscripts} \
    ts_maintel_standardscripts=${ts_maintel_standardscripts} \
    ts_externalscripts=${ts_externalscripts} \
    ts_atmcs=${ts_atmcs} \
    ts_atdome=${ts_atdome} \
    ts_atdometrajectory=${ts_atdometrajectory} \
    ts_attcpip=${ts_attcpip} \
    ts_simactuators=${ts_simactuators} \
    ts_hexrotcomm=${ts_hexrotcomm} \
    ts_tcpip=${ts_tcpip} \
    ts_criopy=${ts_criopy} \
    ts_m1m3_utils=${ts_m1m3_utils} \
    ts_planning_tool=${ts_planning_tool} \
    CHECKOUT_HELPER=${HOME}/.checkout_repo.sh \
    ${HOME}/.setup_ts_environment.sh ${ENVNAME}

RUN ts_config_ocs=${ts_config_ocs} \
    ts_config_attcs=${ts_config_attcs} \
    ts_config_mtcalsys=${ts_config_mtcalsys} \
    ts_config_eas=${ts_config_eas} \
    ts_config_latiss=${ts_config_latiss} \
    ts_config_mttcs=${ts_config_mttcs} \
    ts_config_atcalsys=${ts_config_atcalsys} \
    ts_xml=${ts_xml} \
    ts_idl=${ts_idl} \
    ts_sal=${ts_sal} \
    ts_utils=${ts_utils} \
    ts_salobj=${ts_salobj} \
    ts_scriptqueue=${ts_scriptqueue} \
    ts_observatory_control=${ts_observatory_control} \
    ts_standardscripts=${ts_standardscripts} \
    ts_auxtel_standardscripts=${ts_auxtel_standardscripts} \
    ts_maintel_standardscripts=${ts_maintel_standardscripts} \
    ts_externalscripts=${ts_externalscripts} \
    ts_atmcs=${ts_atmcs} \
    ts_atdome=${ts_atdome} \
    ts_atdometrajectory=${ts_atdometrajectory} \
    ts_attcpip=${ts_attcpip} \
    ts_simactuators=${ts_simactuators} \
    ts_hexrotcomm=${ts_hexrotcomm} \
    ts_tcpip=${ts_tcpip} \
    ts_criopy=${ts_criopy} \
    ts_m1m3_utils=${ts_m1m3_utils} \
    ts_planning_tool=${ts_planning_tool} \
    CHECKOUT_HELPER=${HOME}/.checkout_repo.sh \
    ${HOME}/.setup_ts_environment.sh ssw-3.14

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/current
ENV JAVA_HOME=/usr/lib/jvm/zulu${openjdk}
ENV MAVEN_HOME=/usr/lib/maven/apache-maven-${maven}
ENV PATH=${PATH}:${MAVEN_HOME}/bin

RUN cat <<EOF >> ${HOME}/.bashrc
conda activate ${ENVNAME}
setup ts_config_ocs -t current
setup ts_config_atcalsys -t current
setup ts_config_mtcalsys -t current
setup ts_config_attcs -t current
setup ts_config_mttcs -t current
setup ts_config_eas -t current
setup ts_config_latiss -t current
EOF

LABEL maintainer="Tiago Ribeiro <tribeiro@lsst.org>" \
    image_tag=${lsstsqre} \
    ts_develop=${ts_develop} \
    gphoto2=${gphoto2}\
    labjack_file_version=${labjack_file_version} \
    labjack_arch=${labjack_arch} \
    labjack_ljm=${labjack_ljm}
