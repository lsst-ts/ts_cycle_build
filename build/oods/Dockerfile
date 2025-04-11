ARG cycle
ARG hub

FROM ${hub}/deploy-sqre:${cycle}

WORKDIR ${WORKDIR}
RUN cd && \
    source ${WORKDIR}/loadLSST.bash && \
    conda install -y -c lsstts ts-develop=${ts_develop}

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}
ARG oods

USER root
RUN dnf install -y \
    git-lfs \
    bzip2 \
    libglvnd-glx \
    libglvnd-opengl

USER ${LSST_USER}

WORKDIR ${WORKDIR}

RUN git clone https://github.com/lsst/obs_lsst.git

WORKDIR ${WORKDIR}/obs_lsst
RUN source ${HOME}/.setup_sal_env.sh && \
    eups declare -r . -t $USER && \
    setup obs_lsst -t $USER && \
    scons -j 10

WORKDIR ${WORKDIR}

RUN source ${HOME}/.setup_sal_env.sh && \
    cd ${HOME} && \
    git clone https://github.com/lsst-dm/ctrl_oods && \
    cd ${HOME}/ctrl_oods && \
    git checkout ${oods} && \
    chown -R saluser.saluser ${HOME}/ctrl_oods && \
    eups declare -r . ctrl_oods ${ctrl_oods} -t current && \
    setup -t current ctrl_oods && \
    scons
