# Dockerfile to execute a base machine with the MTAOS simulation environment

ARG deploy_tag
ARG hub=lsstts

FROM ${hub}/deploy-sqre:${deploy_tag}

USER root
RUN dnf install -y git-lfs bzip2

USER ${USER}

WORKDIR  ${HOME}
RUN git clone https://github.com/lsst-ts/ts_config_attcs.git && \
    git clone https://github.com/lsst-ts/ts_config_ocs.git && \
    git clone https://github.com/lsst-ts/ts_observatory_control.git && \
    git clone https://github.com/lsst-ts/cwfs.git && \
    git clone https://github.com/lsst-ts/ts_wep.git && \
    git clone https://github.com/lsst-dm/Spectractor.git && \
    git clone https://github.com/lsst-ts/ts_observing_utilities.git && \
    git clone https://github.com/lsst-dm/atmospec.git && \
    git clone https://github.com/lsst-sitcom/summit_utils.git && \
    git clone https://github.com/lsst-sitcom/summit_extras.git && \
    git clone https://github.com/lsst-ts/ts_externalscripts.git && \
    git clone https://github.com/lsst-ts/ts_standardscripts.git && \
    git clone https://github.com/lsst-ts/ts_scriptqueue.git

ARG ts_config_attcs
ARG ts_config_ocs

WORKDIR ${HOME}/ts_config_attcs
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_config_attcs} && \
    eups declare -m none -r . ts_config_attcs ${ts_config_attcs}

WORKDIR ${HOME}/ts_config_ocs
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_config_ocs} && \
    eups declare -m none -r . ts_config_ocs ${ts_config_ocs}

WORKDIR ${WORKDIR}

ARG ts_utils
ARG ts_atdome
ARG ts_atdometrajectory
ARG ts_atmcssimulator

RUN source ${HOME}/.setup_sal_env.sh && \
    mamba install -y -c lsstts ts-atdome=${ts_atdome} ts-atdometrajectory=${ts_atdometrajectory} ts-atmcs-simulator=${ts_atmcssimulator} ts-utils=${ts_utils} && \
    utils_path=$(python -c 'from lsst.ts import utils; import pathlib; print(pathlib.Path(utils.__file__).parents[0])') && \
    eups declare -m none -r ${utils_path} ts_utils ${ts_utils} && \
    atdome_path=$(python -c 'from lsst.ts import atdome; import pathlib; print(pathlib.Path(atdome.__file__).parents[0])') && \
    eups declare -m none -r ${atdome_path} ts_atdome ${ts_atdome} && \
    atdometrajectory_path=$(python -c 'from lsst.ts import atdometrajectory; import pathlib; print(pathlib.Path(atdometrajectory.__file__).parents[0])') && \
    eups declare -m none -r ${atdometrajectory_path} ts_atdometrajectory ${ts_atdometrajectory} && \
    atmcssimulator_path=$(python -c 'from lsst.ts import atmcssimulator; import pathlib; print(pathlib.Path(atmcssimulator.__file__).parents[0])') && \
    eups declare -m none -r ${atmcssimulator_path} ts_atmcssimulator ${ts_atmcssimulator}

ARG ts_develop

RUN cd && \
    source ${WORKDIR}/loadLSST.bash && \
    mamba install -y -c lsstts ts-develop=${ts_develop}

ARG ts_observatory_control
WORKDIR ${HOME}/ts_observatory_control
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_observatory_control} && \
    (git lfs install; git lfs fetch --all; git lfs checkout);  \
    eups declare -r . ts_observatory_control ${ts_observatory_control} -t current && \
    setup ts_config_ocs && \
    setup ts_observatory_control && \
    scons

ARG cwfs
WORKDIR ${HOME}/cwfs
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${cwfs} && \
    eups declare -r . cwfs ${cwfs} -t current && \
    setup lsst_distrib && \
    setup cwfs -t current && \
    scons

ARG ts_wep
WORKDIR ${HOME}/ts_wep
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_wep} && \
    eups declare -r . ts_wep ${ts_wep} -t current && \
    setup lsst_distrib && \
    setup ts_wep -t current && \
    scons

# Temporarily disabling local copy of Spectractor. It is now part of DM-stack
# ARG Spectractor
# WORKDIR ${HOME}/Spectractor
# RUN source ${HOME}/.setup_sal_env.sh && \
#     /home/saluser/.checkout_repo.sh ${Spectractor} && \
#     pip install -r requirements.txt && \
#     pip install -e .

ARG atmospec
WORKDIR ${HOME}/atmospec
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${atmospec} && \
    setup lsst_distrib && \
    eups declare -r . atmospec -t ${USER} && \
    setup atmospec -t $USER && \
    scons || echo "Atmospec failed..."

ARG summit_utils
WORKDIR ${HOME}/summit_utils
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${summit_utils} && \
    setup lsst_distrib && \
    eups declare -r . summit_utils -t ${USER} && \
    setup summit_utils -t $USER && \
    scons || echo "Summit utils failed..."

ARG summit_extras
WORKDIR ${HOME}/summit_extras
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${summit_extras} && \
    setup lsst_distrib && \
    eups declare -r . summit_extras -t ${USER} && \
    setup summit_extras -t $USER && \
    scons || echo "Summit extras build failed..."

ARG ts_observing_utilities
WORKDIR ${HOME}/ts_observing_utilities
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_observing_utilities} && \
    eups declare -r . -t $USER

ARG ts_externalscripts
WORKDIR ${HOME}/ts_externalscripts
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_externalscripts} && \
    eups declare -r . ts_externalscripts ${ts_externalscripts} -t current && \
    setup ts_externalscripts && \
    scons || echo FAILED to build ts_externalscripts

ARG ts_standardscripts
WORKDIR ${HOME}/ts_standardscripts
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_standardscripts}  && \
    eups declare -r . ts_standardscripts ${ts_standardscripts} -t current && \
    setup ts_standardscripts && \
    setup ts_config_attcs && \
    setup ts_config_ocs && \
    pytest || pytest --lf -x

ARG ts_scriptqueue
WORKDIR ${HOME}/ts_scriptqueue
RUN source ${HOME}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_scriptqueue}  && \
    eups declare -r . ts_scriptqueue ${ts_scriptqueue} -t current && \
    setup ts_scriptqueue && \
    scons || pytest --lf -x

WORKDIR ${HOME}

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
    ts_utils=${ts_utils} \
    ts_atdome=${ts_atdome} \
    ts_atdometrajectory=${ts_atdometrajectory} \
    ts_atmcssimulator=${ts_atmcssimulator} \
    ts_config_attcs=${ts_config_attcs} \
    cwfs=${cwfs} \
    Spectractor=${Spectractor} \
    summit_utils=${summit_utils} \
    summit_extras=${summit_extras} \
    atmospec=${atmospec} \
    ts_observing_utilities=${ts_observing_utilities} \
    ts_observatory_control=${ts_observatory_control} \
    ts_externalscripts=${ts_externalscripts} \
    ts_standardscripts=${ts_standardscripts} \
    ts_scriptqueue=${ts_scriptqueue}
