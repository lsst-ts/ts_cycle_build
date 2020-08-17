ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV OSPL_MASTER_PRIORITY=200
COPY setup.sh /home/saluser/.setup.sh

USER saluser
