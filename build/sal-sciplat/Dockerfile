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
    conda install -c lsstts -y \
    ts-xml=${ts_xml} \
    ts-utils=${ts_utils} \
    ts-idl=${ts_idl}

# Workaround for pin on python-confluent-kafka.
RUN sed -i 's/    "python-confluent-kafka >=1.9.2,<2",/    "python-confluent-kafka >=1.9.2",/' /opt/lsst/software/stack/conda/envs/lsst-scipipe-9.0.0/conda-meta/rubin-env-nosysroot*

ARG ts_salobj
ARG librdkafka
ARG python_confluent_kafka

RUN source ${LOADSTACK} && \
    conda list && \
    conda install -c lsstts/label/rc -y \
    librdkafka=${librdkafka} \
    python-confluent-kafka=${python_confluent_kafka} \
    ts-salobj=${ts_salobj}

#### Clear the astropy download cache
RUN source ${LOADSTACK} && \
    python3 -c 'from astropy.utils.data import clear_download_cache; \
    clear_download_cache()'

ARG ts_sal
ARG ts_criopy
ARG ts_m1m3_utils
ARG ts_atdome
ARG ts_atdometrajectory
ARG ts_atmcssimulator

RUN source ${LOADSTACK} && \
    conda install -c lsstts -y \
    ts-xml=${ts_xml} \
    ts-utils=${ts_utils} \
    ts-idl=${ts_idl}

RUN source ${LOADSTACK} && \
    conda install -c lsstts -c lsstts/label/rc -y \
    ts-salobj=${ts_salobj}

RUN source ${LOADSTACK} && \
    conda install -c lsstts -y \
    ts-atdome=${ts_atdome} \
    ts-atdometrajectory=${ts_atdometrajectory} \
    ts-atmcs-simulator=${ts_atmcssimulator} \
    ts-criopy=${ts_criopy} \
    ts-m1m3-utils=${ts_m1m3_utils}

RUN source ${LOADSTACK} && \
    xml_path=$(python -c 'from lsst.ts import xml; import pathlib; print(pathlib.Path(xml.__file__).parents[0])') && \
    eups declare -m none -r ${xml_path} ts_xml ${ts_xml}  && \
    utils_path=$(python -c 'from lsst.ts import utils; import pathlib; print(pathlib.Path(utils.__file__).parents[0])') && \
    eups declare -m none -r ${utils_path} ts_utils ${ts_utils}  && \
    salobj_path=$(python -c 'from lsst.ts import salobj; import pathlib; print(pathlib.Path(salobj.__file__).parents[0])') && \
    eups declare -m none -r ${salobj_path} ts_salobj ${ts_salobj}  && \
    idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
    eups declare -m none -r ${idl_path} ts_idl ${ts_idl}_${ts_xml}_${ts_sal} && \
    atdome_path=$(python -c 'from lsst.ts import atdome; import pathlib; print(pathlib.Path(atdome.__file__).parents[0])') && \
    eups declare -m none -r ${atdome_path} ts_atdome ${ts_atdome} && \
    atdometrajectory_path=$(python -c 'from lsst.ts import atdometrajectory; import pathlib; print(pathlib.Path(atdometrajectory.__file__).parents[0])') && \
    eups declare -m none -r ${atdometrajectory_path} ts_atdometrajectory ${ts_atdometrajectory} && \
    criopy_path=$(python -c 'from lsst.ts import criopy; import pathlib; print(pathlib.Path(criopy.__file__).parents[0])') && \
    eups declare -m none -r ${criopy_path} ts_criopy ${ts_criopy} && \
    atmcssimulator_path=$(python -c 'from lsst.ts import atmcssimulator; import pathlib; print(pathlib.Path(atmcssimulator.__file__).parents[0])') && \
    eups declare -m none -r ${atmcssimulator_path} ts_atmcssimulator ${ts_atmcssimulator}

ARG ts_config_ocs
ARG ts_config_attcs
ARG ts_config_mtcalsys
ARG ts_config_eas
ARG ts_config_latiss
ARG ts_config_mttcs
ARG ts_config_atcalsys
ARG ts_observatory_control
ARG ts_standardscripts
ARG ts_auxtel_standardscripts
ARG ts_maintel_standardscripts
ARG ts_externalscripts

# Only clone and setup the packages that are really necessary to be managed
# with eups. Everything else is installed using conda.
WORKDIR ${SRCDIR}
RUN source ${LOADSTACK} && \
    gitsrc="ts_config_ocs:${ts_config_ocs} \
    ts_config_attcs:${ts_config_attcs} \
    ts_config_mtcalsys:${ts_config_mtcalsys} \
    ts_config_eas:${ts_config_eas} \
    ts_config_latiss:${ts_config_latiss} \
    ts_config_mttcs:${ts_config_mttcs} \
    ts_config_atcalsys:${ts_config_atcalsys} \
    ts_observatory_control:${ts_observatory_control} \
    ts_standardscripts:${ts_standardscripts} \
    ts_auxtel_standardscripts:${ts_auxtel_standardscripts} \
    ts_maintel_standardscripts:${ts_maintel_standardscripts} \
    ts_externalscripts:${ts_externalscripts}" && \
    rb="https://github.com/lsst-ts" && \
    set -e && \
    for g in $gitsrc ; do \
    r=$(echo ${g} | cut -d ':' -f 1) \
    t=$(echo ${g} | cut -d ':' -f 2) ;\
    retag=${t//a/"-alpha."} ; \
    retag=${retag//b/"-beta."} ; \
    retag=${retag//rc/"-rc."} ; \
    retag=$(echo "$retag" | sed 's/\.$//') ; \
    git clone --branch v${retag} --depth 1 --single-branch ${rb}/${r}.git ; \
    cd ${r} ; \
    git checkout -b ${t} ; \
    eups declare -r . -t current ${r} ${t}; \
    cd .. ; \
    done

# Check that packages can be imported.
RUN source ${SALSTACK} && \
    python -c "from lsst.ts.observatory import control" && \
    python -c "from lsst.ts import standardscripts" && \
    python -c "from lsst.ts import auxtel_standardscripts" && \
    python -c "from lsst.ts import maintel_standardscripts" && \
    python -c "from lsst.ts import externalscripts"

USER lsst
WORKDIR /opt/lsst/software/stack/

