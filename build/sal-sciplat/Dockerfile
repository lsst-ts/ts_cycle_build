ARG image_tag

FROM lsstsqre/centos:${image_tag}

USER root

WORKDIR /usr/share/zoneinfo

USER root

RUN curl https://www.ietf.org/timezones/data/leap-seconds.list -o leap-seconds.list

ENV LOADSTACK=/opt/lsst/software/stack/loadLSST.bash

ENV SRCDIR=/opt/lsst/src
ENV SALSTACK=/opt/lsst/sal/salbldsteps.bash
ENV TZ="UTC"

ENV QT_API="PySide6"
ENV PYTEST_QT_API="PySide6"

COPY sal-sciplat/salbldsteps.bash ${SALSTACK}
COPY sal-sciplat/print_stack_version.sh /opt/lsst/sal/print_stack_version.sh
COPY common/conda_package_spec.sh /opt/lsst/sal/conda_package_spec.sh

RUN mkdir -p ${SRCDIR} && \
    chown -R lsst:lsst ${SRCDIR} && \
    chown -R lsst:lsst /opt/lsst/sal/print_stack_version.sh && \
    chmod a+x ${SALSTACK} && \
    chmod a+x /opt/lsst/sal/print_stack_version.sh

USER lsst

# Conda install TSSW packages that are frozen. These are seldom changed by

RUN source ${LOADSTACK} && \
    conda config --set solver libmamba && \
    conda install -c conda-forge -y \
    aiokafka \
    astroquery \
    asynctest \
    ephem \
    kafkacat \
    pre-commit \
    pytest-tornasync \
    setuptools_scm \
    astroplan

RUN source ${LOADSTACK} && \
    conda install -c conda-forge -y \
    boto3 \
    fastavro \
    jsonschema \
    moto=5 \
    pyyaml

# users during operations.
ARG ts_xml
ARG ts_idl
ARG ts_utils

RUN source ${LOADSTACK} && \
    source /opt/lsst/sal/conda_package_spec.sh && \
    conda install -c lsstts -y \
    "$(conda_package_spec ts-xml "${ts_xml}")" \
    "$(conda_package_spec ts-utils "${ts_utils}")" \
    "$(conda_package_spec ts-idl "${ts_idl}")"

# Workaround for pin on python-confluent-kafka.
RUN sed -i 's/    "python-confluent-kafka >=1.9.2,<2",/    "python-confluent-kafka >=1.9.2",/' /opt/lsst/software/stack/conda/envs/lsst-scipipe-9.0.0/conda-meta/rubin-env-nosysroot* || echo "Failed to work around python-confluent-kafka pin."

ARG ts_salobj
ARG librdkafka
ARG python_confluent_kafka

RUN source ${LOADSTACK} && \
    source /opt/lsst/sal/conda_package_spec.sh && \
    conda list && \
    conda install -c lsstts/label/rc -y \
    librdkafka=${librdkafka} \
    python-confluent-kafka=${python_confluent_kafka} \
    "$(conda_package_spec ts-salobj "${ts_salobj}")"

#### Clear the astropy download cache
RUN source ${LOADSTACK} && \
    python3 -c 'from astropy.utils.data import clear_download_cache; \
    clear_download_cache()'

ARG ts_sal
ARG ts_criopy
ARG ts_m1m3_utils
ARG ts_atdome
ARG ts_atdometrajectory
ARG ts_atmcs

RUN source ${LOADSTACK} && \
    source /opt/lsst/sal/conda_package_spec.sh && \
    conda install -c lsstts -y \
    "$(conda_package_spec ts-xml "${ts_xml}")" \
    "$(conda_package_spec ts-utils "${ts_utils}")" \
    "$(conda_package_spec ts-idl "${ts_idl}")"

RUN source ${LOADSTACK} && \
    source /opt/lsst/sal/conda_package_spec.sh && \
    conda install -c lsstts -c lsstts/label/rc -y \
    "$(conda_package_spec ts-salobj "${ts_salobj}")"

USER lsst
WORKDIR /opt/lsst/software/stack/
