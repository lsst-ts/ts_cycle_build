FROM no_stack AS stack-foundation

ARG stack
USER root
RUN /tmp/install-rpm-packages.sh stack

USER saluser
WORKDIR ${STACKDIR}
RUN ENV_NAME=$(cat /tmp/env_name) && \
    curl -LO https://ls.st/lsstinstall && \
    bash lsstinstall -p "${STACKDIR}/conda" -e "$ENV_NAME" -T ${stack}

ENV EUPS_PKGROOT=https://eups.lsst.cloud/stack/redhat/el7/conda-system/miniconda3-py38_4.9.2-12.1.0|https://eups.lsst.cloud/stack/src

RUN ENV_NAME=$(cat /tmp/env_name) && \
    source ${STACKDIR}/loadLSST.bash && \
    conda install -n "$ENV_NAME" -y ts-develop-rsp && \
    eups distrib install -t ${stack} lsst_distrib && \
    conda clean --all --yes

RUN ENV_NAME=$(cat /tmp/env_name) && \
    GDAL_VERSION=$(conda list -n "$ENV_NAME" | awk '$1 == "gdal" || $1 == "libgdal" || $1 == "libgdal-core" { print $2; exit }') && \
    if [ -z "$GDAL_VERSION" ] || ! printf '%s\n%s\n' 3.13 "$GDAL_VERSION" | sort -V -C; then \
      conda install -n "$ENV_NAME" -y gdal=3.10; \
    fi && \
    conda clean --all --yes

FROM stack-foundation AS stack-base

FROM stack-base AS salobj

ENV LSST_SCHEMA_REGISTRY_URL=http://schema-registry:8081 \
    LSST_KAFKA_HOST=broker \
    LSST_KAFKA_BROKER_PORT=29092 \
    LSST_KAFKA_PREFIX=sal
COPY --chown=saluser:saluser --chmod=755 develop-env/stack/salobj/setup.sh /home/saluser/.setup.sh

WORKDIR /home/saluser/repos/ts_salobj
ENV LSST_SAL_PREFIX=/opt/lsst/tssw/ts_sal
RUN source /home/saluser/.setup_salobj.sh && \
    mkdir -p ${LSST_SAL_PREFIX}/lib && \
    setup ts_config_ocs -t current && \
    setup ts_xml -t current && \
    conda install -y orjson authlib jansson tcllib && \
    conda clean --all --yes && \
    python -c "from lsst.ts import salobj"
USER root
# setupSALKafkaBuildEnvironment otherwise replaces the configured Zulu JAVA_HOME
# with an unavailable java-17-openjdk path.
RUN sed -i 's|^export JAVA_HOME=/usr/lib/jvm/java-17-openjdk$|# JAVA_HOME is provided by the base image|' \
    ${LSST_SAL_PREFIX}/bin/setupSALKafkaBuildEnvironment

RUN source /home/saluser/.setup_salobj.sh && \
    JAVA_HOME=/usr/lib/jvm/java-21-zulu-openjdk-ca \
    MAVEN_ARGS="-T 1C" MAKEFLAGS="-j$(nproc)" ARGS="-E memcheck_" \
    ${LSST_SAL_PREFIX}/bin/setupSALKafkaBuildEnvironment avro

RUN source /home/saluser/.setup_salobj.sh && \
    MAKEFLAGS="-j$(nproc)" ${LSST_SAL_PREFIX}/bin/setupSALKafkaBuildEnvironment librdkafka

RUN source /home/saluser/.setup_salobj.sh && \
    MAKEFLAGS="-j$(nproc)" ${LSST_SAL_PREFIX}/bin/setupSALKafkaBuildEnvironment libschemaregistry

USER saluser
RUN source /home/saluser/.setup_salobj.sh && \
    setup ts_xml -t current && \
    setup ts_sal -t current && \
    source ${TS_SAL_DIR}/setupKafka.env && \
    salgeneratorKafka validate Test

WORKDIR /home/saluser
CMD ["/home/saluser/.setup.sh"]

FROM salobj AS develop-env-stack

COPY --chown=saluser:saluser --chmod=755 develop-env/stack/develop-env/setup.sh /home/saluser/.setup_dev.sh
WORKDIR /home/saluser
CMD ["/home/saluser/.setup_dev.sh"]
