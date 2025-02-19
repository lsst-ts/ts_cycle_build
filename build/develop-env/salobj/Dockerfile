ARG base_image_tag
ARG hub=lsstts

FROM ${hub}/base-sqre:$base_image_tag

USER saluser

COPY checkout_repo.sh /home/saluser/.checkout_repo.sh
COPY setup.sh /home/saluser/.setup.sh

ENV TSSW_PATH=/opt/lsst/tssw
ENV LSST_SCHEMA_REGISTRY_URL=http://schema-registry:8081
ENV LSST_KAFKA_HOST=broker
ENV LSST_KAFKA_BROKER_PORT=29092
ENV LSST_KAFKA_PREFIX=sal

USER root
RUN chown saluser:saluser /home/saluser/.checkout_repo.sh && \
    chmod a+x /home/saluser/.checkout_repo.sh && \
    chown saluser:saluser /home/saluser/.setup.sh && \
    chmod a+x /home/saluser/.setup.sh && \
    mkdir ${TSSW_PATH} && \
    chown saluser:saluser ${TSSW_PATH}

USER saluser

RUN ln -s ${TSSW_PATH} /home/saluser/repos

ARG ts_config_ocs="develop"
ARG ts_config_attcs="develop"
ARG ts_config_mtcalsys="develop"
ARG ts_config_eas="develop"
ARG ts_config_latiss="develop"
ARG ts_config_mttcs="develop"
ARG ts_config_atcalsys="develop"
ARG ts_xml="develop"
ARG ts_idl="develop"
ARG ts_sal="develop"
ARG ts_utils="develop"
ARG ts_salobj="develop"

RUN source /home/saluser/.setup_salobj.sh && \
    cd ${TSSW_PATH} && \
    gitsrc="ts_config_ocs:${ts_config_ocs} \
    ts_config_attcs:${ts_config_attcs} \
    ts_config_mtcalsys:${ts_config_mtcalsys} \
    ts_config_eas:${ts_config_eas} \
    ts_config_latiss:${ts_config_latiss} \
    ts_config_mttcs:${ts_config_mttcs} \
    ts_config_atcalsys:${ts_config_atcalsys} \
    ts_idl:${ts_idl} \
    ts_xml:${ts_xml} \
    ts_sal:${ts_sal}" \
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

RUN source /home/saluser/.setup_salobj.sh && \
    cd ${TSSW_PATH} && \
    gitsrc="ts_utils:${ts_utils} \
    ts_idl:${ts_idl} \
    ts_salobj:${ts_salobj}" && \
    rb="https://github.com/lsst-ts" && \
    for g in $gitsrc ; do \
    r=$(echo ${g} | cut -d ':' -f 1) \
    t=$(echo ${g} | cut -d ':' -f 2) ;\
    git clone ${rb}/${r}.git ; \
    cd ${r} ; \
    /home/saluser/.checkout_repo.sh ${t} ; \
    python -m pip install --no-deps --ignore-installed -e . ; \
    eups declare -m none -r . ${r} ${t} ; \
    cd .. ; \
    done

WORKDIR /home/saluser/repos/ts_salobj
RUN source /home/saluser/.setup_salobj.sh && \
    setup ts_config_ocs -t current && \
    setup ts_xml -t current && \
    python -c "from lsst.ts import salobj"

ENV LSST_SAL_PREFIX=/opt/lsst/tssw/ts_sal
RUN source /home/saluser/.setup_salobj.sh && \
    mkdir ${LSST_SAL_PREFIX}/lib && \
    conda install -y jansson

USER root
RUN source /home/saluser/.setup_salobj.sh && \
    ${LSST_SAL_PREFIX}/bin/setupSALKafkaBuildEnvironment update

RUN source /home/saluser/.setup_salobj.sh && \
    ${LSST_SAL_PREFIX}/bin/setupSALKafkaBuildEnvironment avro || echo "Failed."

RUN source /home/saluser/.setup_salobj.sh && \
    ${LSST_SAL_PREFIX}/bin/setupSALKafkaBuildEnvironment librdkafka || echo "Failed."

RUN source /home/saluser/.setup_salobj.sh && \
    ${LSST_SAL_PREFIX}/bin/setupSALKafkaBuildEnvironment libserdes || echo "Failed."

USER saluser

RUN source /home/saluser/.setup_salobj.sh && \
    setup ts_xml -t current && \
    setup ts_sal -t current && \
    source ${TS_SAL_DIR}/setupKafka.env && \
    salgeneratorKafka validate Test

WORKDIR /home/saluser/

LABEL ts_config_ocs="${ts_config_ocs}" \
    ts_config_attcs="${ts_config_attcs}" \
    ts_config_mtcalsys="${ts_config_mtcalsys}" \
    ts_config_eas="${ts_config_eas}" \
    ts_config_latiss="${ts_config_latiss}" \
    ts_config_mttcs="${ts_config_mttcs}" \
    ts_config_atcalsys="${ts_config_atcalsys}" \
    ts_xml="${ts_xml}" \
    ts_sal="${ts_sal}" \
    ts_salobj="${ts_salobj}"

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
