ARG base_image_tag
ARG hub=lsstts

FROM ${hub}/salobj:${base_image_tag}

COPY setup.sh /home/saluser/.setup_dev.sh

USER root
RUN chown saluser:saluser /home/saluser/.setup_dev.sh && \
    chmod a+x /home/saluser/.setup_dev.sh
USER saluser

ARG ts_scriptqueue="develop"
ARG ts_observatory_control="develop"
ARG ts_standardscripts="develop"
ARG ts_externalscripts="develop"
ARG ts_atmcssimulator="develop"
ARG ts_atdome="develop"
ARG ts_atdometrajectory="develop"
ARG ts_attcpip="develop"
ARG ts_simactuators="develop"
ARG ts_hexrotcomm="develop"
ARG ts_tcpip="develop"
ARG ts_criopy="develop"

RUN source /home/saluser/.setup_salobj.sh && \
    cd ${TSSW_PATH} && \
    gitsrc="ts_scriptqueue:${ts_scriptqueue} \
    ts_observatory_control:${ts_observatory_control} \
    ts_standardscripts:${ts_standardscripts} \
    ts_externalscripts:${ts_externalscripts} \
    ts_atmcssimulator:${ts_atmcssimulator} \
    ts_atdome:${ts_atdome} \
    ts_atdometrajectory:${ts_atdometrajectory} \
    ts_attcpip:${ts_attcpip} \
    ts_simactuators:${ts_simactuators} \
    ts_hexrotcomm:${ts_hexrotcomm} \
    ts_tcpip:${ts_tcpip} \
    ts_criopy:${ts_criopy}" && \
    rb="https://github.com/lsst-ts" && \
    for g in $gitsrc ; do \
    r=$(echo ${g} | cut -d ':' -f 1) \
    t=$(echo ${g} | cut -d ':' -f 2) ;\
    git clone ${rb}/${r}.git ; \
    cd ${r} ; \
    /home/saluser/.checkout_repo.sh ${t} ; \
    eups declare -r . -t current ; \
    cd .. ; \
    done

WORKDIR /home/saluser/
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    setup ts_xml -t current && \
    make_idl_files.py --all

WORKDIR /home/saluser/repos/ts_simactuators
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    eups declare -r . ts_simactuators -t current && setup ts_simactuators -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_atdome
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    setup ts_xml -t current && \
    eups declare -r . ts_atdome -t current && setup ts_atdome -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_atdometrajectory
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    setup ts_xml -t current && \
    eups declare -r . ts_atdometrajectory -t current && \
    setup ts_atdometrajectory -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_atmcssimulator
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    setup ts_xml -t current && \
    eups declare -r . ts_atmcssimulator -t current && \
    setup ts_atmcssimulator -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_criopy
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    setup ts_xml -t current && \
    eups declare -r . ts_criopy -t current && \
    setup ts_criopy -t current && \
    scons || pytest tests/ --color=no --last-failed

WORKDIR /home/saluser/repos/ts_observatory_control
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    git lfs install && \
    git lfs fetch --all && \
    git lfs checkout && \
    setup ts_xml -t current && \
    eups declare -r . -t current && \
    setup ts_observatory_control -t current && \
    setup ts_config_ocs -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_standardscripts
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_sal -t current && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    setup ts_config_ocs -t current && \
    setup ts_atmcssimulator -t current && \
    setup ts_xml -t current && \
    eups declare -r . -t current && \
    setup ts_standardscripts -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_externalscripts
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_sal -t current && \
    setup ts_salobj -t current && \
    setup ts_standardscripts -t current && \
    setup ts_config_attcs -t current && \
    setup ts_config_ocs -t current && \
    setup ts_xml -t current && \
    eups declare -r . -t current && \
    setup ts_externalscripts -t current && \
    scons || echo Building external script failed. IGNORING...

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN source /home/saluser/.setup_salobj.sh && \
    setup lsst_distrib && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    setup ts_salobj -t current && \
    setup ts_xml -t current && \
    eups declare -r . -t current && \
    setup ts_scriptqueue -t current && \
    pytest --color=no || pytest --last-failed

WORKDIR /home/saluser/

LABEL ts_scriptqueue="${ts_scriptqueue}" \
    ts_observatory_control="${ts_observatory_control}" \
    ts_standardscripts="${ts_standardscripts}" \
    ts_externalscripts="${ts_externalscripts}" \
    ts_atmcssimulator="${ts_atmcssimulator}" \
    ts_atdome="${ts_atdome}" \
    ts_atdometrajectory="${ts_atdometrajectory}" \
    ts_simactuators="${ts_simactuators}" \
    ts_hexrotcomm="${ts_hexrotcomm}" \
    ts_tcpip="${ts_tcpip}"

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup_dev.sh"]
