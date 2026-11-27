ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer="Petr Kubanek <petr.kubanek@noirlab.edu>"

ARG vms_logger

WORKDIR /home/saluser/

ENV RUN_ARG=""

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y -c lsstts "$(conda_package_spec ts-vms-logger "${vms_logger}")"

USER saluser

LABEL ts-vms-logger=${vms_logger}
