# Dockerfile to execute a base machine with all set to test active optics
# system software

ARG base_image_tag
ARG hub=lsstts

FROM ${hub}/deploy-sqre:${base_image_tag}

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/$LSST_USER
ARG LSST_DIR=/opt/lsst/software/stack

WORKDIR ${LSST_DIR}
USER lsst

RUN source ${WORKDIR}/loadLSST.bash && \
    conda install -y scikit-image

USER saluser
WORKDIR /home/saluser/

ARG lsst_sims
# Install the lsst_sims and needed packages
RUN source $LSST_DIR/loadLSST.bash && \
    eups distrib install lsst_sims ${lsst_sims}

LABEL lsst_sims=${lsst_sims}
