ARG cycle
ARG hub

FROM ${hub}/deploy-sqre:${cycle}

WORKDIR ${WORKDIR}
RUN cd && \
    source ${WORKDIR}/loadLSST.bash && \
    mamba install -y -c lsstts ts-develop=${ts_develop}

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}


USER root
RUN dnf install -y \
    git-lfs \
    bzip2 \
    libglvnd-glx

USER ${LSST_USER}

WORKDIR ${WORKDIR}

RUN source ${HOME}/.setup_sal_env.sh && \
    cd ${HOME} && \
    git clone https://github.com/lsst-dm/ctrl_oods && \
    cd ${HOME}/ctrl_oods && \
    git checkout ${ctrl_oods} && \
    chown -R saluser.saluser ${HOME}/ctrl_oods && \
    setup -kr . && \
    scons
