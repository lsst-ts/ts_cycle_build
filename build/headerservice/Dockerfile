ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Eric Coughlin <ecoughlin@lsst.org>

ARG headerservice

WORKDIR /home/saluser/

ENV RUN_ARG=""

RUN source /opt/lsst/software/stack/miniconda/bin/activate && \
    conda install -y fitsio pyyaml && \
    git clone https://github.com/lsst-dm/HeaderService -b ${headerservice} && \
    cd HeaderService && \
    export PYTHONPATH=$PYTHONPATH:$CONDA_PREFIX/HeaderService/python &&\
    python setup.py install --prefix=$CONDA_PREFIX/HeaderService --install-lib=$CONDA_PREFIX/HeaderService/python --install-data $CONDA_PREFIX/HeaderService &&\
    python setup.py install_data --install-dir=$CONDA_PREFIX/HeaderService

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

USER saluser

ENV CAMERA=""

LABEL headerservice=${headerservice}
