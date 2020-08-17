# Dockerfile to execute a base machine with the MTAOS simulation environment

ARG IMAGE_TAG
ARG hub=lsstts

FROM ${hub}/aos_aoclc:${IMAGE_TAG}

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}

USER root
COPY develop-env/salobj/checkout_repo.sh ${LSST_USER_HOME}/.checkout_repo.sh
# Copy the file for the start of container with interactive environment
COPY mtaos_sim/setup.sh ${LSST_USER_HOME}/setup.sh
COPY mtaos_sim/startup.sh ${LSST_USER_HOME}/startup.sh

RUN chmod a+x ${LSST_USER_HOME}/.checkout_repo.sh && \
    chmod a+x ${LSST_USER_HOME}/setup.sh && \
    chmod a+x ${LSST_USER_HOME}/startup.sh

WORKDIR ${WORKDIR}

USER lsst

ARG ts_idl
RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl_env.sh && \
    source ${OSPL_HOME}/release.com && \
    export PATH=${WORKDIR}/bin:${PATH} && \
    conda install -y -c lsstts ts-idl=${ts_idl}

# Change to LSST user
USER ${LSST_USER}
WORKDIR ${LSST_USER_HOME}

RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl_env.sh && \
    source ${OSPL_HOME}/release.com && \
    export PATH=${WORKDIR}/bin:${PATH} && \
    idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
    eups declare -m none -r ${idl_path} ts_idl ${ts_idl}

ARG AOS_REPOS=${LSST_USER_HOME}/repos
ARG mtaos=develop
ARG ts_config_mttcs

# Download the required repos and checkout correct versions
RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl_env.sh && \
    source ${OSPL_HOME}/release.com && \
    export PATH=${WORKDIR}/bin:${PATH} && \
    cd ${AOS_REPOS} \
    && git clone https://github.com/lsst-ts/ts_MTAOS.git \
    && git clone https://github.com/lsst-ts/ts_config_mttcs.git \
    && cd ts_MTAOS/ \
    && /home/saluser/.checkout_repo.sh ${mtaos} \
    && eups declare -r . ts_MTAOS ${mtaos} -t current \
    && cd ../ts_config_mttcs \
    && /home/saluser/.checkout_repo.sh ${ts_config_mttcs} \
    && eups declare -r . ts_config_mttcs ${ts_config_mttcs} -t current

LABEL author="Tiago Ribeiro <tribeiro@lsst.org>" \
      ts_idl=${ts_idl} \
      mtaos=${mtaos} \
      ts_config_mttcs=${ts_config_mttcs}

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
CMD ["./startup.sh"]
