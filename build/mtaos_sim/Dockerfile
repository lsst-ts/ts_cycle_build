# Dockerfile to execute a base machine with the MTAOS simulation environment

ARG cycle
ARG hub
ARG ts_conda_build

FROM ${hub}/deploy-sqre:${cycle}

USER lsst
RUN cd && \
    source ${WORKDIR}/loadLSST.bash && \
    conda install -c lsstts ts-conda-build=${ts_conda_build}

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}

USER ${LSST_USER}

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}

WORKDIR ${WORKDIR}

ARG AOS_REPOS=${LSST_USER_HOME}/repos
ARG phosim_utils
ARG ts_wep
ARG ts_ofc
ARG mtaos=develop
ARG ts_config_mttcs

# Download the required repos and checkout correct versions
RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl_env.sh && \
    source ${OSPL_HOME}/release.com && \
    export PATH=${WORKDIR}/bin:${PATH} && \
    mkdir ${AOS_REPOS} \
    && cd ${AOS_REPOS} \
    && git clone https://github.com/lsst-dm/phosim_utils.git \
    && git clone https://github.com/lsst-ts/ts_wep.git \
    && git clone https://github.com/lsst-ts/ts_ofc.git \
    && git clone https://github.com/lsst-ts/ts_MTAOS.git \
    && git clone https://github.com/lsst-ts/ts_config_mttcs.git \
    && cd ${AOS_REPOS}/phosim_utils \
    && /home/saluser/.checkout_repo.sh ${phosim_utils} \
    && eups declare -r . phosim_utils ${phosim_utils} -t current \
    && cd ${AOS_REPOS}/ts_wep \
    && /home/saluser/.checkout_repo.sh ${ts_wep} \
    && eups declare -r . ts_wep ${ts_wep} -t current \
    && cd ${AOS_REPOS}/ts_ofc \
    && /home/saluser/.checkout_repo.sh ${ts_ofc} \
    && eups declare -r . ts_ofc ${ts_ofc} -t current \
    && cd ${AOS_REPOS}/ts_MTAOS/ \
    && /home/saluser/.checkout_repo.sh ${mtaos} \
    && eups declare -r . ts_MTAOS ${mtaos} -t current \
    && cd ../ts_config_mttcs \
    && /home/saluser/.checkout_repo.sh ${ts_config_mttcs} \
    && eups declare -r . ts_config_mttcs ${ts_config_mttcs} -t current

# Run scons on each package
# phosim_utils
WORKDIR ${AOS_REPOS}/phosim_utils
RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl_env.sh && \
    source ${OSPL_HOME}/release.com && \
    setup phosim_utils -t current && \
    scons

# wep
WORKDIR ${AOS_REPOS}/ts_wep
RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl_env.sh && \
    source ${OSPL_HOME}/release.com && \
    setup ts_wep -t current && \
    scons || echo FAILED! Ignore and move on... 

# ofc
WORKDIR ${AOS_REPOS}/ts_ofc
RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl_env.sh && \
    source ${OSPL_HOME}/release.com && \
    setup ts_ofc -t current && \
    scons

# mtaos
WORKDIR ${AOS_REPOS}/ts_MTAOS
RUN source ${WORKDIR}/loadLSST.bash && \
    source ${WORKDIR}/ospl_env.sh && \
    source ${OSPL_HOME}/release.com && \
    setup ts_MTAOS -t current && \
    scons || pytest --lf

LABEL author="Tiago Ribeiro <tribeiro@lsst.org>" \
      phosim_utils=${phosim_utils} \
      ts_wep=${ts_wep} \
      ts_ofc=${ts_ofc} \
      mtaos=${mtaos} \
      ts_config_mttcs=${ts_config_mttcs}

# Set the default environment
WORKDIR $LSST_USER_HOME
ENV RUN_ARG=""

USER root
# Copy the file for the start of container with interactive environment
COPY mtaos_sim/startup.sh ${LSST_USER_HOME}/.startup.sh

RUN chown saluser:saluser ${LSST_USER_HOME}/.startup.sh && \
    chmod a+x ${LSST_USER_HOME}/.startup.sh

USER ${LSST_USER}
