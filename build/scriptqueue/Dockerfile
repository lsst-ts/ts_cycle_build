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

# Change to LSST user
USER ${LSST_USER}
WORKDIR ${LSST_USER_HOME}

ARG ts_idl
RUN source ${LSST_USER_HOME}/.setup_sal_env.sh && \
    conda install -y -c lsstts ts-idl=${ts_idl} && \
    idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
    eups declare -m none -r ${idl_path} ts_idl ${ts_idl}


LABEL author="Tiago Ribeiro <tribeiro@lsst.org>" \
      ts_idl=${ts_idl} \
      mtaos=${mtaos} \
      ts_config_mttcs=${ts_config_mttcs}

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
CMD ["./startup.sh"]
