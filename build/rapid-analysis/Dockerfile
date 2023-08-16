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
    mamba install -y -c conda-forge \
    rubin-env-rsp \
    astrometry \
    redis-py

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
    git clone https://github.com/lsst-camera-dh/eo_pipe.git

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
    setup obs_lsst -j -t saluser && \
    setup spectractor -t saluser && \
    setup atmospec -j -t saluser && \
    scons opt=3

WORKDIR /repos/summit_utils

ARG summit_utils_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${summit_utils_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst -j -t saluser && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    scons opt=3 -j 4 || echo tests failed...

WORKDIR /repos/summit_extras

ARG summit_extras_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${summit_extras_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst -j -t saluser && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    setup summit_extras -j -t saluser && \
    scons opt=3 -j 4 || echo tests failed...

ARG rubintv_production_work_branch

WORKDIR /repos/eo_pipe

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${rubintv_production_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst -j -t saluser && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    setup summit_extras -j -t saluser && \
    setup rubintv_production -j -t saluser && \
    setup eo_pipe -j -t saluser && \
    scons opt=3 -j 4 || echo tests failed...

WORKDIR /repos/rubintv_production

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${rubintv_production_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst -j -t saluser && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    setup summit_extras -j -t saluser && \
    setup rubintv_production -j -t saluser && \
    scons opt=3 -j 4 || echo tests failed...

ENV RUN_ARG="-v"
ENV DEPLOY_BRANCH=${rubintv_production_work_branch}

COPY rapid-analysis/startup.sh /repos/.startup.sh

USER root

RUN chown saluser:saluser /repos/.startup.sh && \
    chmod a+x /repos/.startup.sh

USER saluser

WORKDIR /repos/rubintv_production/scripts

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/repos/.startup.sh"]