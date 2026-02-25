FROM almalinux:9

ARG UID=73006
ARG GID=73006

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
ENV WORKDIR /opt/lsst/software/stack

USER root

RUN groupadd --gid ${GID} saluser && \
  adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

RUN dnf install -y dnf-plugins-core && dnf config-manager --set-enabled crb

COPY deploy-env/conda/startup.sh /home/saluser/.startup.sh
COPY deploy-env/conda/setup_sal_env.sh /home/saluser/.setup_sal_env.sh
COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh
COPY common/lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo
COPY common/wait_obsenv_sidecar.sh /home/saluser/.wait_obsenv_sidecar.sh

ENV QT_API="PySide6"
ENV PYTEST_QT_API="PySide6"

RUN mkdir -p ${WORKDIR} && \
  chmod -R a+rw ${WORKDIR}/../ && \
  chown -R saluser:saluser /opt/lsst/ && \
  chown -R saluser:saluser ${HOME} && \
  chown saluser:saluser /home/saluser/.startup.sh && \
  chown saluser:saluser /home/saluser/.setup_sal_env.sh && \
  chown saluser:saluser /home/saluser/.checkout_repo.sh && \
  chown saluser:saluser /home/saluser/.wait_obsenv_sidecar.sh && \
  chmod a+x /home/saluser/.startup.sh && \
  chmod a+x /home/saluser/.setup_sal_env.sh && \
  chmod a+x /home/saluser/.wait_obsenv_sidecar.sh && \
  dnf install -y git make gcc-c++ procps-ng which && \
  chmod a+x /home/saluser/.checkout_repo.sh

# Make sure that saluser can use the ping command
RUN if [ -f "/bin/ping" ]; then \
    setcap cap_net_raw+ep /bin/ping; \
  fi

USER saluser

WORKDIR ${WORKDIR}

ARG ts_idl
ARG ts_xml
ARG ts_utils
ARG ts_salobj
ARG librdkafka
ARG python_confluent_kafka

ARG PYTHON_VERSION

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -o miniforge.sh && \
  chmod +x miniforge.sh && \
  ./miniforge.sh -b -p ${WORKDIR}/miniconda && \
  source /home/saluser/.setup_sal_env.sh && \
  conda update -y -n base -c conda-forge conda conda-libmamba-solver --solver classic && \
  conda config --set solver libmamba && \
  conda install -y python=${PYTHON_VERSION} && \
  conda config --add channels conda-forge && \
  conda config --add channels lsstts && \
  conda install -y librdkafka=${librdkafka} python-confluent-kafka=${python_confluent_kafka} && \
  conda install -y -c lsstts -c lsstts/label/dev -c lsstts/label/rc ts-xml=${ts_xml} ts-salobj=${ts_salobj} ts-idl=${ts_idl} ts-utils=${ts_utils} pyopenssl

WORKDIR /home/saluser/

LABEL ts-xml=${ts_xml} \
  ts_idl=${ts_idl} \
  ts_utils=${ts_utils} \
  ts_salobj=${ts_salobj}

ENTRYPOINT ["/home/saluser/.startup.sh"]
