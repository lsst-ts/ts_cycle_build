ARG cycle
ARG hub

FROM ${hub}/genericcamera:${cycle}

LABEL maintainer Michael Reuter <mreuter@lsst.org>

ARG vimba
ARG vimba_conda_build

COPY common/netrc /home/saluser/.netrc
COPY genericcamera/vimba/startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh && \
    chown saluser:saluser /home/saluser/.netrc

USER saluser

RUN source /home/saluser/.setup_sal_env.sh && \
    curl -O --netrc-file /home/saluser/.netrc https://repo-nexus.lsst.org/nexus/repository/av-vimba/vimba-${vimba}-${vimba_conda_build}.tar.bz2 && \
    conda install -y ./vimba-${vimba}-${vimba_conda_build}.tar.bz2 && \
    rm /home/saluser/.netrc vimba-${vimba}-${vimba_conda_build}.tar.bz2

LABEL vimba=${vimba}-${vimba_conda_build}
