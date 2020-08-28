# Dockerfile to execute a base machine with the MTAOS simulation environment

ARG deploy_tag
ARG hub=lsstts

FROM ${hub}/deploy-sqre:${deploy_tag}

USER ${USER}

WORKDIR  ${SAL_HOME}
RUN git clone https://github.com/lsst-ts/ts_config_attcs.git && \
    git clone https://github.com/lsst-ts/ts_config_ocs.git && \
    git clone https://github.com/lsst-ts/ts_observatory_control.git && \
    git clone https://github.com/lsst-ts/ts_externalscripts.git && \
    git clone https://github.com/lsst-ts/ts_standardscripts.git && \
    git clone https://github.com/lsst-ts/ts_scriptqueue.git

ARG ts_config_attcs
ARG ts_config_ocs
ARG ts_observatory_control
ARG ts_externalscripts
ARG ts_standardscripts
ARG ts_scriptqueue

WORKDIR ${SAL_HOME}/ts_config_attcs
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_config_attcs} && \
    eups declare -m none -r . ts_config_attcs ${ts_config_attcs}

WORKDIR ${SAL_HOME}/ts_config_ocs
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_config_ocs} && \
    eups declare -m none -r . ts_config_ocs ${ts_config_ocs}

WORKDIR ${WORKDIR}

USER lsst

ARG ts_idl
ARG ts_atdome
ARG ts_atdometrajectory
ARG ts_atmcssimulator

RUN source ${WORKDIR}/.setup_sal_env.sh && \
    conda install -y asynctest pytest-tornasync astroquery black && \
    conda install -y -c lsstts ts-idl=${ts_idl} ts-atdome=${ts_atdome} ts-atdometrajectory=${ts_atdometrajectory} ts-atmcs-simulator=${ts_atmcssimulator} && \
    idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
    eups declare -m none -r ${idl_path} ts_idl ${ts_idl} && \
    atdome_path=$(python -c 'from lsst.ts import ATDome; import pathlib; print(pathlib.Path(ATDome.__file__).parents[0])') && \
    eups declare -m none -r ${atdome_path} ts_ATDome ${ts_atdome} && \
    atdometrajectory_path=$(python -c 'from lsst.ts import ATDomeTrajectory; import pathlib; print(pathlib.Path(ATDomeTrajectory.__file__).parents[0])') && \
    eups declare -m none -r ${atdometrajectory_path} ts_ATDomeTrajectory ${ts_atdometrajectory} && \
    atmcssimulator_path=$(python -c 'from lsst.ts import ATMCSSimulator; import pathlib; print(pathlib.Path(ATMCSSimulator.__file__).parents[0])') && \
    eups declare -m none -r ${atmcssimulator_path} ts_ATMCSSimulator ${ts_atmcssimulator}

USER ${USER}

WORKDIR ${SAL_HOME}/ts_observatory_control
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_observatory_control} && \
    eups declare -r . ts_observatory_control ${ts_observatory_control} -t current && \
    setup ts_config_ocs && \
    setup ts_observatory_control && \
    scons

WORKDIR ${SAL_HOME}/ts_externalscripts
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_externalscripts} && \
    eups declare -r . ts_externalscripts ${ts_externalscripts} -t current && \
    setup ts_externalscripts && \
    scons || echo FAILED to build ts_externalscripts

WORKDIR ${SAL_HOME}/ts_standardscripts
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_standardscripts}  && \
    eups declare -r . ts_standardscripts ${ts_standardscripts} -t current && \
    setup ts_standardscripts && \
    setup ts_config_attcs && \
    pytest || pytest --lf -x

WORKDIR ${SAL_HOME}/ts_scriptqueue
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_scriptqueue}  && \
    eups declare -r . ts_scriptqueue ${ts_scriptqueue} -t current && \
    setup ts_scriptqueue && \
    scons || pytest --lf -x

WORKDIR ${SAL_HOME}

COPY scriptqueue/startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser

ENV RUN_ARG="--verbose 1"
ENV LSST_DDS_DOMAIN=citest

LABEL author="Tiago Ribeiro <tribeiro@lsst.org>" \
      ts_config_attcs=${ts_config_attcs} \
      ts_config_ocs=${ts_config_ocs} \
      ts_idl=${ts_idl} \
      ts_atdome=${ts_atdome} \
      ts_atdometrajectory=${ts_atdometrajectory} \
      ts_atmcssimulator=${ts_atmcssimulator} \
      ts_config_attcs=${ts_config_attcs} \
      ts_observatory_control=${ts_observatory_control} \
      ts_externalscripts=${ts_externalscripts} \
      ts_standardscripts=${ts_standardscripts} \
      ts_scriptqueue=${ts_scriptqueue}
