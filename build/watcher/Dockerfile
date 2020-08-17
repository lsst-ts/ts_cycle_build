ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs

ARG config_ocs
WORKDIR /home/saluser/ts_config_ocs
RUN /home/saluser/.checkout_repo.sh ${config_ocs}

WORKDIR /home/saluser/

ARG idl
ARG watcher
RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-idl=${idl} ts-watcher=${watcher}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org> \
      environment ${deploy_env} \
      ts_idl ${idl} \
      salobj ${deploy_tag} \
      ts_config_ocs ${config_ocs} \
      ts_watcher ${watcher}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
