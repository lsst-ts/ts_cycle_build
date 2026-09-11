FROM almalinux:9 AS common

ARG UID=73006
ARG GID=73006

ENV USER=saluser \
    HOME=/home/saluser \
    STACKDIR=/opt/lsst/software/stack \
    WORKDIR=/opt/lsst/software/stack \
    TSSW_PATH=/opt/lsst/tssw

USER root
RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

RUN if [ -d "${HOME}/.cache" ]; then \
      chown -R saluser:saluser "${HOME}/.cache"; \
    fi

COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/lsst-ts-nexus-private.repo /etc/yum.repos.d/lsst-ts-private.repo
COPY develop-env/stack/lsstsqre/gitconfig ${HOME}/.gitconfig
COPY develop-env/stack/lsstsqre/toolchains.xml /root/.m2/toolchains.xml
COPY develop-env/stack/lsstsqre/setup_env.sh /home/saluser/.setup_salobj.sh
COPY --chown=saluser:saluser --chmod=755 develop-env/stack/setup-current.sh /home/saluser/.setup-current.sh
COPY common/install_labjack.sh /tmp/install_labjack.sh
COPY develop-env/scripts/install-rpm-packages.sh /tmp/install-rpm-packages.sh
COPY develop-env/scripts/configure-conda-solver.sh /tmp/configure-conda-solver.sh

RUN chmod +x /tmp/install_labjack.sh /tmp/install-rpm-packages.sh /tmp/configure-conda-solver.sh

WORKDIR /usr/share/zoneinfo
RUN curl -O https://tf.nist.gov/leap-seconds.list

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

FROM common AS no-stack

ARG python_version=3.13
ARG gphoto2
ARG labjack_file_version
ARG labjack_arch
ARG labjack_ljm
ARG maven
ARG openjdk
ARG ts_develop
ARG use_rattler_solver=false
ARG ts_config_ocs=develop
ARG ts_config_attcs=develop
ARG ts_config_mtcalsys=develop
ARG ts_config_eas=develop
ARG ts_config_latiss=develop
ARG ts_config_mttcs=develop
ARG ts_config_atcalsys=develop
ARG ts_xml=develop
ARG ts_idl=develop
ARG ts_sal=develop
ARG ts_utils=develop
ARG ts_salobj=develop
ARG ts_scriptqueue=develop
ARG ts_observatory_control=develop
ARG ts_standardscripts=develop
ARG ts_auxtel_standardscripts=develop
ARG ts_maintel_standardscripts=develop
ARG ts_externalscripts=develop
ARG ts_atmcs=develop
ARG ts_atdome=develop
ARG ts_atdometrajectory=develop
ARG ts_attcpip=develop
ARG ts_simactuators=develop
ARG ts_hexrotcomm=develop
ARG ts_tcpip=develop
ARG ts_criopy=develop
ARG ts_m1m3_utils=develop
ARG ts_planning_tool=develop
USER root
RUN /tmp/install-rpm-packages.sh no-stack && \
    rm /etc/yum.repos.d/lsst-ts-private.repo && \
    mkdir -p ${STACKDIR} && chown -R saluser:saluser /opt/lsst
USER saluser
WORKDIR ${HOME}
RUN wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && \
    bash Miniforge3.sh -b -p "${STACKDIR}/conda" && \
    source "${STACKDIR}/conda/etc/profile.d/conda.sh" && \
    conda init && \
    conda config --add channels lsstts && \
    conda config --add channels conda-forge && \
    bash /tmp/configure-conda-solver.sh "${use_rattler_solver}" && \
    conda create -n ssw-${python_version} python=${python_version} ts-develop=${ts_develop} eups && \
    if [[ "${python_version}" != 3.14 ]]; then \
      conda create -n ssw-3.14 python=3.14 ts-develop=${ts_develop} eups; \
    fi && \
    conda clean --all --yes && \
    rm -f Miniforge3.sh && \
    echo "ssw-${python_version}" > /tmp/env_name
ENV PATH=${STACKDIR}/conda/bin:${PATH}
USER root
RUN chmod +x /tmp/install_labjack.sh && \
    /tmp/install_labjack.sh --labjack_file_version=${labjack_file_version} \
      --labjack_arch=${labjack_arch} --labjack_ljm=${labjack_ljm} \
      --saluser_env_script=/home/saluser/.setup-ssw-environment.sh
RUN dnf install -y https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm && \
    dnf install -y zulu${openjdk}-jdk zulu11-jdk zulu21-jdk && \
    dnf clean all && \
    rm -rf /var/cache/dnf
ENV MAVEN_HOME=/usr/lib/maven/apache-maven-${maven} \
    JAVA_HOME=/usr/lib/jvm/zulu${openjdk}
ENV PATH=${PATH}:${MAVEN_HOME}/bin
WORKDIR /usr/lib/maven
RUN curl -LO https://archive.apache.org/dist/maven/maven-3/${maven}/binaries/apache-maven-${maven}-bin.tar.gz && \
    tar zxf apache-maven-${maven}-bin.tar.gz && \
    rm apache-maven-${maven}-bin.tar.gz
USER saluser
RUN ENV_NAME=$(cat /tmp/env_name) && \
    conda install -n "$ENV_NAME" -y ltd-conveyor setuptools==81 && \
    LDFLAGS="-L/usr/lib64" LIBRARY_PATH="/usr/lib64" \
    conda run -n "$ENV_NAME" uv pip install gphoto2==${gphoto2} --no-deps --only-binary :all: && \
    conda run -n "$ENV_NAME" uv pip install rawpy==0.24 --no-deps && \
    conda clean --all --yes && \
    uv cache clean
COPY develop-env/scripts/checkout-repo.sh /home/saluser/.checkout-repo.sh
COPY develop-env/scripts/setup-ssw-repositories.sh /home/saluser/.setup-ssw-repositories.sh
COPY develop-env/no-stack/setup-ssw-environment.sh /home/saluser/.setup-ssw-environment.sh
USER root
RUN chmod +x /home/saluser/.checkout-repo.sh /home/saluser/.setup-ssw-repositories.sh /home/saluser/.setup-ssw-environment.sh
USER saluser
RUN mkdir -p ${TSSW_PATH} && ln -s ${TSSW_PATH} /home/saluser/repos || true
RUN ENV_NAME=$(cat /tmp/env_name) && \
    ts_config_ocs=${ts_config_ocs} ts_config_attcs=${ts_config_attcs} \
    ts_config_mtcalsys=${ts_config_mtcalsys} ts_config_eas=${ts_config_eas} \
    ts_config_latiss=${ts_config_latiss} ts_config_mttcs=${ts_config_mttcs} \
    ts_config_atcalsys=${ts_config_atcalsys} ts_xml=${ts_xml} ts_idl=${ts_idl} \
    ts_sal=${ts_sal} ts_utils=${ts_utils} ts_salobj=${ts_salobj} \
    ts_scriptqueue=${ts_scriptqueue} ts_observatory_control=${ts_observatory_control} \
    ts_standardscripts=${ts_standardscripts} ts_auxtel_standardscripts=${ts_auxtel_standardscripts} \
    ts_maintel_standardscripts=${ts_maintel_standardscripts} ts_externalscripts=${ts_externalscripts} \
    ts_atmcs=${ts_atmcs} ts_atdome=${ts_atdome} ts_atdometrajectory=${ts_atdometrajectory} \
    ts_attcpip=${ts_attcpip} ts_simactuators=${ts_simactuators} ts_hexrotcomm=${ts_hexrotcomm} \
    ts_tcpip=${ts_tcpip} ts_criopy=${ts_criopy} ts_m1m3_utils=${ts_m1m3_utils} \
    ts_planning_tool=${ts_planning_tool} CHECKOUT_HELPER=/home/saluser/.checkout-repo.sh \
    SETUP_REPOSITORIES=/home/saluser/.setup-ssw-repositories.sh \
    /home/saluser/.setup-ssw-environment.sh "$ENV_NAME"
RUN cat <<EOF >> ${HOME}/.bashrc
ENV_NAME=\$(cat /tmp/env_name)
conda activate "\${ENV_NAME}"
setup ts_config_ocs -t current
setup ts_config_atcalsys -t current
setup ts_config_mtcalsys -t current
setup ts_config_attcs -t current
setup ts_config_mttcs -t current
setup ts_config_eas -t current
setup ts_config_latiss -t current
EOF
WORKDIR /home/saluser
CMD ["/bin/bash"]
