FROM almalinux:9 AS common

ARG UID=73006
ARG GID=73006
ARG node

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
COPY common/conda_package_spec.sh ${HOME}/.conda_package_spec.sh
COPY develop-env/stack/lsstsqre/gitconfig ${HOME}/.gitconfig
COPY develop-env/stack/lsstsqre/setup_env.sh /home/saluser/.setup_salobj.sh
COPY common/install_labjack.sh /tmp/install_labjack.sh
COPY develop-env/scripts/install-rpm-packages.sh /tmp/install-rpm-packages.sh
COPY develop-env/scripts/configure-conda-solver.sh /tmp/configure-conda-solver.sh

WORKDIR /usr/share/zoneinfo
RUN curl -O ftp://ftp.boulder.nist.gov/pub/time/leap-seconds.list

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

FROM common AS foundation

ARG stack
ARG python_version
ARG gphoto2
ARG maven
ARG openjdk
ARG ts_develop
ARG use_lsstinstall=true
ARG use_rattler_solver=false
USER root
RUN chmod +x /tmp/install-rpm-packages.sh && \
    if [[ "${use_lsstinstall}" == true ]]; then \
      /tmp/install-rpm-packages.sh stack; \
    else \
      /tmp/install-rpm-packages.sh no-stack; \
    fi && \
    rm /etc/yum.repos.d/lsst-ts-private.repo && \
    mkdir -p ${STACKDIR} && chown -R saluser:saluser /opt/lsst
USER saluser
WORKDIR ${STACKDIR}
RUN if [[ "${use_lsstinstall}" == true ]]; then \
      curl -LO https://ls.st/lsstinstall && bash lsstinstall -T ${stack}; \
    else \
      wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && \
      bash Miniforge3.sh -b -p "${STACKDIR}/conda"; \
    fi
ENV PATH=${STACKDIR}/conda/bin/:$PATH
ENV EUPS_PKGROOT=https://eups.lsst.cloud/stack/redhat/el7/conda-system/miniconda3-py38_4.9.2-12.1.0|https://eups.lsst.cloud/stack/src
RUN if [[ "${use_lsstinstall}" == false ]]; then \
      source "${STACKDIR}/conda/etc/profile.d/conda.sh" && conda init; \
    fi && \
    conda config --add channels lsstts && \
    conda config --add channels conda-forge && \
    bash /tmp/configure-conda-solver.sh "${use_rattler_solver}" && \
    if [[ "${use_lsstinstall}" == true ]]; then \
      conda env list | awk '{print $1}' | grep '^lsst-scipipe-' | head -n1 > /tmp/env_name; \
    else \
      conda create -n ssw-${python_version} python=${python_version} && \
      conda create -n ssw-3.14 python=3.14 && \
      echo "ssw-${python_version}" > /tmp/env_name; \
    fi
RUN if [[ "${use_lsstinstall}" == true ]]; then \
      ENV_NAME=$(cat /tmp/env_name) && \
      GDAL_VERSION=$(conda list -n "$ENV_NAME" | awk '$1 == "gdal" || $1 == "libgdal" || $1 == "libgdal-core" { print $2; exit }') && \
      if [ -z "$GDAL_VERSION" ] || ! printf '%s\n%s\n' 3.13 "$GDAL_VERSION" | sort -V -C; then \
        conda install -n "$ENV_NAME" -y gdal=3.10; \
      fi; \
    fi

FROM foundation AS stack-foundation
FROM stack-foundation AS configured-base

USER root
RUN dnf install -y https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm && \
    dnf install -y zulu${openjdk}-jdk
ENV MAVEN_HOME=/usr/lib/maven/apache-maven-${maven} \
    JAVA_HOME=/usr/lib/jvm/zulu${openjdk}
ENV PATH=${PATH}:${MAVEN_HOME}/bin
WORKDIR /usr/lib/maven
RUN curl -LO https://archive.apache.org/dist/maven/maven-3/${maven}/binaries/apache-maven-${maven}-bin.tar.gz && \
    tar zxf apache-maven-${maven}-bin.tar.gz
USER saluser
RUN ENV_NAME=$(cat /tmp/env_name) && \
    if [[ "${use_lsstinstall}" == true ]]; then \
      source ${STACKDIR}/loadLSST.bash && \
      conda install -n "$ENV_NAME" -y ts-develop-rsp && \
      eups distrib install -t ${stack} lsst_distrib && \
      source ${HOME}/.conda_package_spec.sh && \
      conda install -n "$ENV_NAME" -y -c lsstts "$(conda_package_spec ts-develop "${ts_develop}")"; \
    else \
      conda install -n "$ENV_NAME" -y -c lsstts ts-develop=${ts_develop}; \
    fi && \
    conda install -n "$ENV_NAME" -y ltd-conveyor setuptools==81 && \
    LDFLAGS="-L/usr/lib64" LIBRARY_PATH="/usr/lib64" \
    conda run -n "$ENV_NAME" uv pip install gphoto2==${gphoto2} --no-deps --only-binary :all: && \
    conda run -n "$ENV_NAME" uv pip install rawpy==0.24 --no-deps

FROM configured-base AS stack-base

FROM stack-base AS salobj

ENV LSST_SCHEMA_REGISTRY_URL=http://schema-registry:8081 \
    LSST_KAFKA_HOST=broker \
    LSST_KAFKA_BROKER_PORT=29092 \
    LSST_KAFKA_PREFIX=sal
COPY develop-env/scripts/checkout-repo.sh /home/saluser/.checkout-repo.sh
COPY develop-env/scripts/setup-salobj-repositories.sh /home/saluser/.setup-salobj-repositories.sh
COPY develop-env/stack/salobj/setup.sh /home/saluser/.setup.sh
USER root
RUN chown saluser:saluser /home/saluser/.checkout-repo.sh /home/saluser/.setup-salobj-repositories.sh /home/saluser/.setup.sh && \
    chmod +x /home/saluser/.checkout-repo.sh /home/saluser/.setup-salobj-repositories.sh /home/saluser/.setup.sh && \
    mkdir -p ${TSSW_PATH} && chown saluser:saluser ${TSSW_PATH}
USER saluser

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
RUN source /home/saluser/.setup_salobj.sh && \
    CHECKOUT_HELPER=/home/saluser/.checkout-repo.sh \
    /home/saluser/.setup-salobj-repositories.sh

WORKDIR /home/saluser/repos/ts_salobj
RUN source /home/saluser/.setup_salobj.sh && setup ts_config_ocs -t current && \
    setup ts_xml -t current && conda install -y orjson authlib jansson && \
    python -c "from lsst.ts import salobj"
ENV LSST_SAL_PREFIX=/opt/lsst/tssw/ts_sal
WORKDIR /home/saluser
ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]

FROM salobj AS develop-env-stack

COPY develop-env/stack/develop-env/setup.sh /home/saluser/.setup_dev.sh
COPY develop-env/scripts/setup-develop-repositories.sh /home/saluser/.setup-develop-repositories.sh
USER root
RUN chown saluser:saluser /home/saluser/.setup_dev.sh /home/saluser/.setup-develop-repositories.sh && \
    chmod +x /home/saluser/.setup_dev.sh /home/saluser/.setup-develop-repositories.sh
USER saluser
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
RUN source /home/saluser/.setup_salobj.sh && \
    CHECKOUT_HELPER=/home/saluser/.checkout-repo.sh \
    /home/saluser/.setup-develop-repositories.sh

WORKDIR /home/saluser
ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup_dev.sh"]

FROM configured-base AS no-stack

ARG labjack_file_version
ARG labjack_arch
ARG labjack_ljm
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
RUN chmod +x /tmp/install_labjack.sh && \
    /tmp/install_labjack.sh --labjack_file_version=${labjack_file_version} \
      --labjack_arch=${labjack_arch} --labjack_ljm=${labjack_ljm} \
      --saluser_env_script=/home/saluser/.setup-ssw-environment.sh
USER saluser
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
ENTRYPOINT ["/bin/bash", "--"]
CMD ["/bin/bash"]
