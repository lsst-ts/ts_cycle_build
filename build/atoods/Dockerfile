ARG cycle
ARG hub

FROM ${hub}/oods:${cycle}

WORKDIR ${WORKDIR}
COPY --chown=saluser:saluser startup.sh ${HOME}/.startup.sh
RUN chmod a+x /home/saluser/.startup.sh
