FROM almalinux:9

RUN dnf install -y epel-release && \
    dnf update -y && \
    dnf install -y git vim bash-completion wget iproute && \
    dnf clean all

ENV HOME=/home/saluser
RUN groupadd -g 70014 docker
RUN adduser -G wheel,docker saluser

WORKDIR ${HOME}
COPY . ./ts_atbuilding_vents/
RUN chown -R saluser ${HOME}/ts_atbuilding_vents/

USER saluser
ENV ARCH=aarch64

ARG vents_version

ARG PYTHON_VERSION

RUN \
    wget -O mambaforge.sh \
        https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-${ARCH}.sh && \
    chmod +x mambaforge.sh && \
    ./mambaforge.sh -b -p ${HOME}/miniconda3 && \
    source ${HOME}/miniconda3/bin/activate && \
    conda config --set solver libmamba && \
    conda install -y python=${PYTHON_VERSION} && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    conda install -y conda-build anaconda-client setuptools_scm astropy numpy && \
    conda install -y pymodbus smbus3 && \
    conda install -y -c lsstts ts-tcpip ts-utils ts-atbuilding-vents

LABEL ts-atbuilding-vents=${vents_version}

ENTRYPOINT ["/home/saluser/miniconda3/bin/conda", "run", "python", "-m", "lsst.ts.vent.controller.run_dispatcher"]
