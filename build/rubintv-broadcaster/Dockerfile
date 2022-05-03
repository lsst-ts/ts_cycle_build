ARG image_tag

FROM lsstsqre/centos:w_latest

ENV USER ${USER:-saluser}
ENV SAL_HOME /home/saluser
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

USER lsst

RUN source ${WORKDIR}/loadLSST.bash && \
    mamba install -c conda-forge ciso8601 imagemagick ffmpeg

USER saluser

RUN source ${WORKDIR}/loadLSST.bash && \
    pip install google-cloud-storage

RUN source ${WORKDIR}/loadLSST.bash && \
    pip install lsst-efd-client

RUN mkdir -p ${SAL_HOME}/repos

WORKDIR ${SAL_HOME}/repos

# Clone all repos
RUN git clone https://github.com/lsst/Spectractor.git && \
    git clone https://github.com/lsst/atmospec.git && \
    git clone https://github.com/lsst-sitcom/summit_utils.git && \
    git clone https://github.com/lsst-sitcom/summit_extras.git && \
    git clone https://github.com/lsst-sitcom/rubintv_production.git


WORKDIR ${SAL_HOME}/repos/Spectractor

ARG spectractor_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${spectractor_work_branch} && \
    eups declare -r . -t saluser

WORKDIR ${SAL_HOME}/repos/atmospec

ARG atmospec_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${atmospec_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst -j -t saluser && \
    setup spectractor -t saluser && \
    setup atmospec -j -t saluser && \
    scons opt=3

WORKDIR ${SAL_HOME}/repos/summit_utils

ARG summit_utils_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${summit_utils_work_branch} && \
    eups declare -r . -t saluser && \
    setup lsst_distrib && \
    setup obs_lsst -j -t saluser && \
    setup atmospec -j -t saluser && \
    setup summit_utils -j -t saluser && \
    scons opt=3 -j 4 || echo tests failed...

WORKDIR ${SAL_HOME}/repos/summit_extras

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

WORKDIR ${SAL_HOME}/repos/rubintv_production

ARG rubintv_production_work_branch

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

COPY rubintv-broadcaster/startup.sh /home/saluser/.startup.sh

USER root

RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER saluser

WORKDIR ${SAL_HOME}/repos/rubintv_production/scripts

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.startup.sh"]
