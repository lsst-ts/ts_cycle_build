ARG platform=linux/aarch64
FROM --platform=${platform} almalinux:9

RUN dnf install -y epel-release && \
    dnf update -y && \
    dnf install -y git vim bash-completion wget usbutils pulseaudio alsa-plugins-pulseaudio portaudio libgpiod && \
    dnf clean all

ENV HOME=/home/saluser
RUN groupadd -g 70014 docker
RUN adduser -G wheel,docker saluser
COPY startup.sh ${HOME}/.startup.sh

RUN chown saluser:saluser ${HOME}/.startup.sh && \
    chmod +x ${HOME}/.startup.sh

USER saluser
WORKDIR ${HOME}
ENV ARCH=aarch64

ARG PYTHON_VERSION=3.11
ARG NUMPY_VERSION=1.26.4
ARG audiotrigger

RUN wget -q https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-${ARCH}.sh -O miniforge.sh && \
    chmod +x miniforge.sh && \
    ./miniforge.sh -b -p ${HOME}/miniconda3 && \
    source ${HOME}/miniconda3/bin/activate && \
    conda config --set solver libmamba && \
    conda install -y python=${PYTHON_VERSION} && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    conda config --add channels anaconda && \
    conda install -y conda-build anaconda-client setuptools_scm && \
    conda install -y numpy==${NUMPY_VERSION} astropy && \
    conda install -y ts-audiotrigger=${audiotrigger} && \
    conda remove -y --force portaudio

RUN echo source ${HOME}/miniconda3/bin/activate >> ${HOME}/.bashrc

LABEL ts-audiotrigger=${audiotrigger}

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.startup.sh"]
