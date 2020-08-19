ARG deploy_env=lsstts/deploy-env
ARG deploy_tag=salobj_v5.7.0

FROM ${deploy_env}:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG idl=1.1.3_4.8.0
ARG ts_observatory_control=0.3.0
ARG integration_testing=first_cut

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts -c conda-forge ts-idl=${idl} \
    ts-observatory-control=${ts_observatory_control} \
    astroquery

#ENV OSPL_MASTER_PRIORITY=200
#COPY setup.sh /home/saluser/.setup.sh
COPY checkout_repo.sh /home/saluser/.checkout_repo.sh

USER root

RUN  chown saluser:saluser /home/saluser/.checkout_repo.sh && \
     chmod a+x /home/saluser/.checkout_repo.sh
#    chown saluser:saluser /home/saluser/.setup.sh && \
#    chmod a+x /home/saluser/.setup.sh

USER saluser

WORKDIR /home/saluser/
RUN git clone https://github.com/mareuter/integration_testing.git && \
    cd integration_testing && \
    /home/saluser/.checkout_repo.sh ${integration_testing}
