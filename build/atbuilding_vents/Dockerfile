FROM almalinux:9

RUN dnf install -y epel-release && \
    dnf update -y && \
    dnf install -y git vim bash-completion wget iproute && \
    dnf clean all

ENV HOME=/home/saluser
RUN groupadd -g 70014 docker
RUN adduser -G wheel,docker saluser

WORKDIR ${HOME}

USER saluser
ENV ARCH=aarch64

ARG vents_version
ARG PYTHON_VERSION

RUN \
    wget -O miniforge.sh \
        https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-${ARCH}.sh && \
    chmod +x miniforge.sh && \
    ./miniforge.sh -b -p ${HOME}/miniconda3 && \
    source ${HOME}/miniconda3/bin/activate && \
    conda config --set solver libmamba && \
    conda install -y python=${PYTHON_VERSION} && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    conda install -y -c lsstts ts-atbuilding-vents=${vents_version}

LABEL ts-atbuilding-vents=${vents_version}

ENTRYPOINT ["/home/saluser/miniconda3/bin/conda", "run", "run_dispatcher"]
