FROM almalinux:8

RUN dnf install -y epel-release && \
    dnf update -y && \
    dnf install -y git vim bash-completion wget libftdi libftdi-devel iproute minicom && \
    dnf clean all

COPY minirc.dfl /etc/minirc.dfl

ENV HOME=/home/saluser
RUN groupadd -g 70014 docker
RUN adduser -G wheel,docker saluser
COPY setup.sh ${HOME}/.setup.sh

RUN chown saluser:saluser ${HOME}/.setup.sh && \
    chmod +x ${HOME}/.setup.sh

USER saluser
WORKDIR ${HOME}
ENV ARCH=aarch64

ARG common
ARG controller

ARG PYTHON_VERSION=3.8

RUN wget -q https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-aarch64.sh -O mambaforge.sh && \
    chmod +x mambaforge.sh && \
    ./mambaforge.sh -b -p ${HOME}/miniconda3 && \
    source ${HOME}/miniconda3/bin/activate && \
    mamba install -y python=${PYTHON_VERSION} && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    mamba update -y --all && \
    mamba install -y conda-build anaconda-client setuptools_scm && \
    mamba install -y numpy astropy && \
    mamba install -y ts-ess-common=${common} ts-ess-controller=${controller} && \
    pip install asyncio pyserial pylibftdi pyftdi jsonschema pyyaml

RUN echo source ${HOME}/miniconda3/bin/activate >> ${HOME}/.bashrc

LABEL ts-ess-controller=${controller} \
      ts-ess-common=${common}

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
