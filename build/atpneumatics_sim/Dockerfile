ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atpneumatics_sim

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-atpneumaticssimulator=${atpneumatics_sim}

LABEL ts-atpneumaticssimulator=${atpneumatics_sim}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
