ARG image_tag

FROM lsstsqre/centos:${image_tag}

ENV USER ${USER:-saluser}
ENV WORKDIR /opt/lsst/software/stack

USER root

ARG UID=73006
ARG GID=73006

# Create user and group
RUN if [ $UID -eq 1000 ] && [ $GID -eq 1000 ]; then  \
    echo "Renaming lsst to saluser" && \
    usermod -l saluser lsst && \
    usermod -d /home/saluser -m saluser ; \
    else \
    groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser ; \
    fi

COPY develop-env/salobj/checkout_repo.sh /home/saluser/.checkout_repo.sh

RUN chown saluser:saluser /home/saluser/.checkout_repo.sh && \
    chmod a+x /home/saluser/.checkout_repo.sh

RUN mkdir -p /repos && \
    chmod a+rw /repos && \
    chown saluser:saluser /repos

USER lsst

RUN source ${WORKDIR}/loadLSST.bash && \
    conda install -y -c conda-forge \
    rubin-env-rsp \
    astrometry \
    redis-py \
    rubin-libradtran

USER saluser

RUN source ${WORKDIR}/loadLSST.bash && \
    pip install google-cloud-storage

RUN source ${WORKDIR}/loadLSST.bash && \
    pip install lsst-efd-client

WORKDIR /repos

# Clone all repos
RUN git clone https://github.com/lsst/Spectractor.git && \
    git clone https://github.com/lsst/atmospec.git && \
    git clone https://github.com/lsst-sitcom/summit_utils.git && \
    git clone https://github.com/lsst-sitcom/summit_extras.git && \
    git clone https://github.com/lsst-sitcom/rubintv_production.git && \
    git clone https://github.com/lsst-ts/rubintv_analysis_service.git && \
    git clone https://github.com/lsst-camera-dh/eo_pipe.git

# TODO: (DM-43475) Resync RA images with the rest of the summit.
RUN git clone https://github.com/lsst/obs_lsst.git && \
    git clone https://github.com/lsst/drp_pipe.git

WORKDIR /repos/obs_lsst

RUN source ${WORKDIR}/loadLSST.bash && \
    eups declare -r . -t saluser && \
    setup obs_lsst -t saluser && \
    scons

WORKDIR /repos/drp_pipe

RUN source ${WORKDIR}/loadLSST.bash && \
    eups declare -r . -t saluser && \
    setup drp_pipe -t saluser && \
    scons version

WORKDIR /repos/Spectractor

ARG spectractor_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${spectractor_work_branch} && \
    eups declare -r . -t saluser

WORKDIR /repos/atmospec

ARG atmospec_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${atmospec_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst -j && \
    setup sconsUtils -j && \
    setup spectractor -j -t saluser && \
    setup atmospec -j -t saluser && \
    eups list && \
    scons version

WORKDIR /repos/summit_utils

ARG summit_utils_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${summit_utils_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    setup sconsUtils && \
    scons version

WORKDIR /repos/summit_extras

ARG summit_extras_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${summit_extras_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    setup summit_extras -j -t saluser && \
    setup sconsUtils && \
    scons version

ARG rubintv_production_work_branch

WORKDIR /repos/eo_pipe

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${rubintv_production_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    setup summit_extras -j -t saluser && \
    setup eo_pipe -j -t saluser && \
    setup sconsUtils && \
    scons version

WORKDIR /repos/rubintv_production

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${rubintv_production_work_branch} && \
    eups declare -r . -t saluser && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    setup summit_extras -j -t saluser && \
    setup rubintv_production -j -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst && \
    setup sconsUtils && \
    scons version 

WORKDIR /repos/rubintv_analysis_service

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${rubintv_production_work_branch} && \
    eups declare -r . -t saluser && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    setup summit_extras -j -t saluser && \
    setup rubintv_production -j -t saluser && \
    setup rubintv_analysis_service -j -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst && \
    setup sconsUtils && \
    scons version 

ENV RUN_ARG="-v"
ENV DEPLOY_BRANCH=${rubintv_production_work_branch}
ENV OPENBLAS_NUM_THREADS=1
ENV GOTO_NUM_THREADS=1
ENV OMP_NUM_THREADS=1
ENV MKL_NUM_THREADS=1
ENV MKL_DOMAIN_NUM_THREADS=1
ENV MPI_NUM_THREADS=1
ENV NUMEXPR_NUM_THREADS=1
ENV NUMEXPR_MAX_THREADS=1
ENV MPLBACKEND=Agg

COPY rapid-analysis/startup.sh /repos/.startup.sh

USER root

RUN chown saluser:saluser /repos/.startup.sh && \
    chmod a+x /repos/.startup.sh

USER saluser

WORKDIR /repos/rubintv_production/scripts

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/repos/.startup.sh"]
