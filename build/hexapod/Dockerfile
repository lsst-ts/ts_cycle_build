ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

ARG hexapod=0.1.dev65+ge3a234e
ARG hexrotcomm=0.5.0

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-hexapod=${hexapod} ts-hexrotcomm=${hexrotcomm}

LABEL ts_hexapod=${hexapod} \
      ts_hexrotcomm=${hexrotcomm}

ENV RUN_ARG=""
COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
