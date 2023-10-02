ARG cycle
ARG hub

FROM ${hub}/oods:${cycle}

WORKDIR ${WORKDIR}
COPY --chown=${LSST_USER}:${LSST_USER} --chmod=755 startup.sh ${HOME}/.startup.sh
