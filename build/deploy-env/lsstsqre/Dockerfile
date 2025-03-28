FROM almalinux:9

ARG UID=73006
ARG GID=73006

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
ENV WORKDIR /opt/lsst/software/stack

USER root

RUN dnf install -y mesa-libEGL

RUN groupadd --gid ${GID} saluser && \
  adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

COPY deploy-env/lsstsqre/startup.sh ${HOME}/.startup.sh
COPY deploy-env/lsstsqre/setup_sal_env.sh ${HOME}/.setup_sal_env.sh
COPY develop-env/salobj/checkout_repo.sh ${HOME}/.checkout_repo.sh

# Create user and group
RUN chown ${UID}:${GID} ${HOME}/.startup.sh && \
  chown ${UID}:${GID} ${HOME}/.setup_sal_env.sh && \
  chown ${UID}:${GID} ${HOME}/.checkout_repo.sh && \
  chmod a+x ${HOME}/.startup.sh && \
  chmod a+x ${HOME}/.setup_sal_env.sh && \
  chmod a+x ${HOME}/.checkout_repo.sh && \
  mkdir -p ${WORKDIR} && \
  touch ${WORKDIR}/ospl_env.sh && \
  chown -R ${UID}:${GID} ${WORKDIR} && \
  dnf install -y git make gcc-c++ procps-ng which

# Make sure that saluser can use the ping command
RUN if [ -f "/bin/ping" ]; then \
    setcap cap_net_raw+ep /bin/ping; \
  fi

USER saluser

WORKDIR ${WORKDIR}

ARG stack

RUN curl -LO https://ls.st/lsstinstall && \
  bash lsstinstall -T ${stack}

RUN source ./loadLSST.bash && \
  eups distrib install -t ${stack} lsst_distrib

# Workaround for pin on python-confluent-kafka.
# RUN sed -i 's/    "python-confluent-kafka >=1.9.2,<2",/    "python-confluent-kafka >=1.9.2",/' conda/envs/lsst-scipipe-9.0.0/conda-meta/rubin-env-nosysroot*

ARG ts_xml
ARG ts_idl
ARG ts_utils
ARG ts_salobj
ARG librdkafka
ARG python_confluent_kafka

ENV QT_API="PySide6"
ENV PYTEST_QT_API="PySide6"

WORKDIR ${HOME}

RUN source ${HOME}/.setup_sal_env.sh && \
  conda config --add channels lsstts/label/dev && \
  conda config --add channels lsstts/label/rc && \
  conda config --add channels lsstts && \
  conda config --add channels conda-forge && \
  conda config --set solver libmamba

RUN source ${HOME}/.setup_sal_env.sh && \
  conda install -y python-confluent-kafka=${python_confluent_kafka} && \
  conda install -y librdkafka=${librdkafka}

RUN source ${HOME}/.setup_sal_env.sh && \
  conda install -y cython && \
  conda install -y pyopenssl

RUN source ${HOME}/.setup_sal_env.sh && \
  conda install -y \
  ts-xml=${ts_xml} \
  ts-salobj=${ts_salobj} \
  ts-idl=${ts_idl} \
  ts-utils=${ts_utils} && \
  salobj_path=$(python -c 'from lsst.ts import salobj; import pathlib; print(pathlib.Path(salobj.__file__).parents[0])') && \
  eups declare -m none -r ${salobj_path} ts_salobj ${ts_salobj}  && \
  idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
  eups declare -m none -r ${idl_path} ts_idl ${ts_idl}

# TODO (DM-43904): Remove command to explicity downgrade jaraco.context once this is fixed.
RUN source ./.setup_sal_env.sh && \
    conda install -y jaraco.context=4

USER saluser

WORKDIR /home/saluser/

LABEL stack=${stack} \
  ts_xml=${ts_xml} \
  ts_idl=${ts_idl} \
  ts_utils=${ts_utils} \
  ts_salobj=${ts_salobj}

ENTRYPOINT ["/home/saluser/.startup.sh"]
