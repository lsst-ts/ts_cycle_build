# Dockerfile to execute a base machine with all set to test active optics
# system software with the needed AOS repositories

ARG IMAGE_TAG
ARG hub=lsstts

FROM ${hub}/aos_sal:${IMAGE_TAG}

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}
ARG AOS_REPOS=${LSST_USER_HOME}/repos
ARG PHOSIM_DIR=${LSST_USER_HOME}/phosim
ARG AOCLC_OUTPUT_PATH=${LSST_USER_HOME}/output
ARG LSST_DIR=/opt/lsst/software/stack
ARG SIMS_VERSION=current
ARG phosim_utils
ARG ts_wep
ARG ts_ofc
ARG ts_phosim

# Change to LSST user
USER $LSST_USER

RUN mkdir -p ${AOS_REPOS} && \
    mkdir -p ${PHOSIM_DIR} && \
    mkdir -p ${AOCLC_OUTPUT_PATH}

WORKDIR ${AOS_REPOS}

RUN git clone https://github.com/lsst-dm/phosim_utils.git
RUN git clone https://github.com/lsst-ts/ts_wep.git
RUN git clone https://github.com/lsst-ts/ts_ofc.git
RUN git clone https://github.com/lsst-ts/ts_phosim.git


# Set the PhoSim and output environment variables
ENV PHOSIMPATH "${PHOSIM_DIR}"
ENV AOCLCOUTPUTPATH "${AOCLC_OUTPUT_PATH}"

# Build the packages
WORKDIR ${AOS_REPOS}/phosim_utils/

RUN source ${LSST_DIR}/loadLSST.bash \
    && git checkout ${phosim_utils} \
    && eups declare -r . -t current \
    && setup phosim_utils -t current \
    && scons

WORKDIR $AOS_REPOS/ts_wep/
RUN source ${LSST_DIR}/loadLSST.bash \
    && git checkout ${ts_wep} \
    && eups declare -r . -t current \
    && setup ts_wep -t current \
    && scons

WORKDIR $AOS_REPOS/ts_ofc/
RUN source ${LSST_DIR}/loadLSST.bash \
    && git checkout ${ts_ofc} \
    && eups declare -r . -t current \
    && setup ts_ofc -t current \
    && scons

WORKDIR $AOS_REPOS/ts_phosim/
RUN source ${LSST_DIR}/loadLSST.bash \
    && git checkout ${ts_phosim} \
    && eups declare -r . -t current \
    && setup ts_phosim -t current \
    && scons

# Set the default environment
WORKDIR $LSST_USER_HOME
