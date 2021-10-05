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

USER saluser

RUN source ${WORKDIR}/loadLSST.bash && \
    pip install google-cloud-storage lsst-efd-client

RUN mkdir -p ${SAL_HOME}/repos

WORKDIR ${SAL_HOME}/repos

# Clone all repos
RUN git clone https://github.com/lsst/Spectractor.git && \
    git clone https://github.com/lsst-dm/atmospec.git && \
    git clone https://github.com/lsst-sitcom/rapid_analysis.git

WORKDIR ${SAL_HOME}/repos/Spectractor

ARG spectractor_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${spectractor_work_branch} && \
    pip install -r requirements.txt && \
    pip install -e .

WORKDIR ${SAL_HOME}/repos/atmospec

ARG atmospec_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${atmospec_work_branch} && \
    eups declare -r . -t current && \
    setup lsst_distrib && \
    setup atmospec -j -t current && \
    scons opt=3

WORKDIR ${SAL_HOME}/repos/rapid_analysis

ARG rapid_analysis_work_branch

RUN source ${WORKDIR}/loadLSST.bash && \
    /home/saluser/.checkout_repo.sh ${rapid_analysis_work_branch} && \
    eups declare -r . -t current && \
    setup lsst_distrib && \
    setup atmospec -j -t current && \
    setup rapid_analysis -j -t current && \
    scons opt=3 -j 4

ENV RUN_ARG="-v"

COPY rubintv-broadcaster/startup.sh /home/saluser/.startup.sh

USER root

RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER saluser

WORKDIR ${SAL_HOME}/repos/rapid_analysis/scripts

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.startup.sh"]
