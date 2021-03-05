# Dockerfile to execute a base machine with the MTAOS simulation environment

ARG deploy_tag
ARG hub=lsstts

FROM ${hub}/deploy-sqre:${deploy_tag}

USER ${USER}

WORKDIR  ${SAL_HOME}
RUN git clone https://github.com/lsst-ts/ts_config_attcs.git && \
    git clone https://github.com/lsst-ts/ts_config_ocs.git && \
    git clone https://github.com/lsst-ts/ts_observatory_control.git && \
    git clone https://github.com/bxin/cwfs.git && \
    git clone https://github.com/lsst-dm/Spectractor.git && \
    git clone https://github.com/lsst/obs_base.git && \
    git clone https://github.com/lsst/pipe_tasks.git && \
    git clone https://github.com/lsst-sitcom/rapid_analysis.git && \
    git clone https://github.com/lsst-ts/ts_observing_utilities.git && \
    git clone https://github.com/lsst-dm/atmospec.git && \
    git clone https://github.com/lsst-ts/ts_externalscripts.git && \
    git clone https://github.com/lsst-ts/ts_standardscripts.git && \
    git clone https://github.com/lsst-ts/ts_scriptqueue.git

ARG ts_config_attcs
ARG ts_config_ocs

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

ARG ts_atdome
ARG ts_atdometrajectory
ARG ts_atmcssimulator

RUN source ${WORKDIR}/.setup_sal_env.sh && \
    conda install -y asynctest pytest-tornasync astroquery black && \
    conda install -y -c lsstts ts-atdome=${ts_atdome} ts-atdometrajectory=${ts_atdometrajectory} ts-atmcs-simulator=${ts_atmcssimulator} && \
    atdome_path=$(python -c 'from lsst.ts import ATDome; import pathlib; print(pathlib.Path(ATDome.__file__).parents[0])') && \
    eups declare -m none -r ${atdome_path} ts_ATDome ${ts_atdome} && \
    atdometrajectory_path=$(python -c 'from lsst.ts import ATDomeTrajectory; import pathlib; print(pathlib.Path(ATDomeTrajectory.__file__).parents[0])') && \
    eups declare -m none -r ${atdometrajectory_path} ts_ATDomeTrajectory ${ts_atdometrajectory} && \
    atmcssimulator_path=$(python -c 'from lsst.ts import ATMCSSimulator; import pathlib; print(pathlib.Path(ATMCSSimulator.__file__).parents[0])') && \
    eups declare -m none -r ${atmcssimulator_path} ts_ATMCSSimulator ${ts_atmcssimulator}

USER ${USER}

ARG ts_observatory_control
WORKDIR ${SAL_HOME}/ts_observatory_control
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_observatory_control} && \
    eups declare -r . ts_observatory_control ${ts_observatory_control} -t current && \
    setup ts_config_ocs && \
    setup ts_observatory_control && \
    scons

ARG cwfs
WORKDIR ${SAL_HOME}/cwfs
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${cwfs} && \
    eups declare -r . cwfs ${cwfs} -t current && \
    setup lsst_distrib && \
    setup cwfs -t current && \
    scons

ARG Spectractor
WORKDIR ${SAL_HOME}/Spectractor
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${Spectractor} && \
    pip install -r requirements.txt && \
    pip install -e .

# Skipping obs_base. It is part of the stack now
# ARG obs_base
# WORKDIR ${SAL_HOME}/obs_base
# RUN source ${WORKDIR}/.setup_sal_env.sh && \
#     /home/saluser/.checkout_repo.sh ${obs_base} && \
#     eups declare -r . obs_base -t $USER && \
#     setup obs_base -t $USER && \
#     scons

# Skipping obs_base. It is part of the stack now
# ARG pipe_tasks
# WORKDIR ${SAL_HOME}/pipe_tasks
# RUN source ${WORKDIR}/.setup_sal_env.sh && \
#     /home/saluser/.checkout_repo.sh ${pipe_tasks} && \
#     eups declare -r . pipe_tasks -t $USER && \
#     setup pipe_tasks -t $USER && \
#     scons

ARG rapid_analysis
WORKDIR ${SAL_HOME}/rapid_analysis
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    setup lsst_distrib && \
    /home/saluser/.checkout_repo.sh ${rapid_analysis} && \
    eups declare -r . rapid_analysis -t ${USER} && \
    setup rapid_analysis -t $USER && \
    scons || echo "failed"

ARG atmospec
WORKDIR ${SAL_HOME}/atmospec
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${atmospec} && \
    setup lsst_distrib && \
    eups declare -r . atmospec -t ${USER} && \
    setup atmospec -t $USER && \
    scons || echo "failed"

ARG ts_observing_utilities
WORKDIR ${SAL_HOME}/ts_observing_utilities
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_observing_utilities} && \
    eups declare -r . -t $USER

ARG ts_externalscripts
WORKDIR ${SAL_HOME}/ts_externalscripts
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_externalscripts} && \
    eups declare -r . ts_externalscripts ${ts_externalscripts} -t current && \
    setup ts_externalscripts && \
    scons || echo FAILED to build ts_externalscripts

ARG ts_standardscripts
# FIXME: REMOVING tests/test_black.py because sqre image comes with wrong
# version of black
WORKDIR ${SAL_HOME}/ts_standardscripts
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_standardscripts}  && \
    eups declare -r . ts_standardscripts ${ts_standardscripts} -t current && \
    setup ts_standardscripts && \
    setup ts_config_attcs && \
    rm -rf tests/test_black.py && \
    pytest || pytest --lf -x

ARG ts_scriptqueue
# FIXME: REMOVING tests/test_black.py because sqre image comes with wrong
# version of black
WORKDIR ${SAL_HOME}/ts_scriptqueue
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_scriptqueue}  && \
    eups declare -r . ts_scriptqueue ${ts_scriptqueue} -t current && \
    rm -rf tests/test_black.py && \
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
      cwfs=${cwfs} \
      Spectractor=${Spectractor} \
      obs_base=${obs_base} \
      pipe_tasks=${pipe_tasks} \
      rapid_analysis=${rapid_analysis} \
      atmospec=${atmospec} \
      ts_observing_utilities=${ts_observing_utilities} \
      ts_observatory_control=${ts_observatory_control} \
      ts_externalscripts=${ts_externalscripts} \
      ts_standardscripts=${ts_standardscripts} \
      ts_scriptqueue=${ts_scriptqueue}
