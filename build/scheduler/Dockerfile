ARG deploy_tag
ARG hub=lsstts

FROM ${hub}/aos_sal:${deploy_tag}

WORKDIR ${WORKDIR}

USER lsst

ARG ts_idl

RUN source ${WORKDIR}/.setup_sal_env.sh && \
    conda install -y asynctest pytest-tornasync && \
    conda install -y -c lsstts ts-idl=${ts_idl} && \
    idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
    eups declare -m none -r ${idl_path} ts_idl ${ts_idl}

USER saluser

WORKDIR /home/saluser/

RUN mkdir repos/

WORKDIR /home/saluser/repos/

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git && \
    git clone https://github.com/lsst-ts/ts_scheduler.git && \
    git clone https://github.com/lsst/sims_seeingModel.git && \
    git clone https://github.com/lsst/sims_cloudModel.git && \
    git clone https://github.com/lsst/sims_downtimeModel.git && \
    git clone https://github.com/lsst/sims_utils.git && \
    git clone https://github.com/lsst/ephem.git && \
    git clone https://github.com/lsst/throughputs.git && \
    git clone https://github.com/lsst/sims_photUtils.git && \
    git clone https://github.com/lsst/sims_skybrightness.git && \
    git clone https://github.com/lsst/sims_skybrightness_pre.git && \
    git clone https://github.com/lsst-ts/ts_dateloc.git && \
    git clone https://github.com/lsst-ts/ts_astrosky_model.git && \
    git clone https://github.com/lsst-ts/ts_observatory_model.git && \
    git clone https://github.com/lsst-ts/scheduler_config.git && \
    git clone https://github.com/lsst/sims_skybrightness_data.git && \
    git clone https://github.com/lsst-ts/ts_scriptqueue.git

WORKDIR /home/saluser/repos/sims_utils
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_utils -t current && \
    scons

WORKDIR /home/saluser/repos/sims_cloudModel
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_cloudModel -t current && \
    scons

WORKDIR /home/saluser/repos/sims_downtimeModel
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_downtimeModel -t current && \
    scons

WORKDIR /home/saluser/repos/sims_seeingModel
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_seeingModel -t current && \
    scons

WORKDIR /home/saluser/repos/sims_utils
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_utils -t current && \
    scons

WORKDIR /home/saluser/repos/ephem
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    pip install pyephem && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/throughputs
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/sims_photUtils
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_photUtils -t current && \
    scons

WORKDIR /home/saluser/repos/sims_skybrightness_data
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/sims_skybrightness
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_skybrightness -t current && \
    scons

WORKDIR /home/saluser/repos/sims_skybrightness_pre
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_skybrightness_pre -t current && \
    scons

WORKDIR /home/saluser/repos/ts_dateloc
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup ts_dateloc -t current && \
    scons

WORKDIR /home/saluser/repos/ts_astrosky_model
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup ts_astrosky_model -t current && \
    scons

WORKDIR /home/saluser/repos/ts_observatory_model
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup ts_observatory_model -t current && \
    scons

WORKDIR /home/saluser/repos/scheduler_config
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current

# Work around for deprecated/unneeded packages. Remove when dependency fixed
WORKDIR /home/saluser/repos/

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    mkdir python_future && \
    eups declare -m none -r /home/saluser/repos/python_future python_future git

ARG ts_config_ocs

WORKDIR /home/saluser/repos/ts_config_ocs

RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_config_ocs} && \
    eups declare -r . ts_config_ocs ${ts_config_ocs} -t current

ARG ts_scriptqueue

WORKDIR /home/saluser/repos/ts_scriptqueue

RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_scriptqueue}  && \
    eups declare -r . ts_scriptqueue ${ts_scriptqueue} -t current

ARG ts_scheduler

WORKDIR /home/saluser/repos/ts_scheduler
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_scheduler} && \
    eups declare -r . ts_scheduler ${ts_scheduler} -t current && \
    setup ts_scheduler && \
    py.test

WORKDIR ${SAL_HOME}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser

ENV INDEX=1

LABEL author="Tiago Ribeiro <tribeiro@lsst.org>" \
      palpy=${palpy}  \
      sims_data=${sims_data} \
      sims_survey_fields=${sims_survey_fields} \
      ts_scheduler=${ts_scheduler} \
      ts_config_ocs=${ts_config_ocs}
