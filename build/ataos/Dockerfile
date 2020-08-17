ARG cycle
ARG hub

FROM ${hub}/deploy-sqre:${cycle}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

RUN mkdir -p ${HOME}/repos

WORKDIR /home/saluser/repos

RUN git clone https://github.com/lsst-ts/ts_ataos.git && \
    git clone https://github.com/lsst-ts/ts_observatory_control.git && \
    git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/lsst

USER lsst

ARG ts_idl
RUN source ${WORKDIR}/.setup_sal_env.sh && \
    conda install -y -c lsstts ts-idl=${ts_idl} astroquery && \
    idl_path=$(python -c 'from lsst.ts import idl; import pathlib; print(pathlib.Path(idl.__file__).parents[0])') && \
    eups declare -m none -r ${idl_path} ts_idl ${ts_idl}

USER saluser

ARG config

WORKDIR /home/saluser/repos/ts_config_attcs

RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${config} && \
    eups declare -r . ts_config_attcs $(git describe --long) -t current

ARG ts_observatory_control

WORKDIR /home/saluser/repos/ts_observatory_control

RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ts_observatory_control} && \
    eups declare -r . ts_observatory_control $(git describe --long) -t current

ARG ataos

WORKDIR /home/saluser/repos/ts_ataos

RUN source ${WORKDIR}/.setup_sal_env.sh && \
    /home/saluser/.checkout_repo.sh ${ataos} && \
    eups declare -r . ts_ataos $(git describe --long) -t current && \
    setup ts_ataos -t current && \
    scons || pytest --lf


LABEL ts_idl=${ts_idl} \
      ts_observatory_control=${ts_observatory_control} \
      ts_config_attcs=${config} \
      ts_ataos=${ataos}

WORKDIR /home/saluser/

COPY setup.sh /home/saluser/.setup.sh
