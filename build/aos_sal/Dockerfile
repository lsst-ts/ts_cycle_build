# Dockerfile to execute a base machine with all set to test active optics
# system software

ARG base_image_tag
ARG hub=lsstts

FROM ${hub}/deploy-sqre:${base_image_tag}

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/$LSST_USER
ARG LSST_DIR=/opt/lsst/software/stack
ARG SHEBANGTRON_URL=https://raw.githubusercontent.com/lsst/shebangtron/master/shebangtron

USER root

# Install the required packages
RUN yum install -y csh wget \
    && yum clean all \
    && rm -rf /var/cache/yum

# Set the default user of container
USER $LSST_USER

# Install the lsst_sims and needed packages
RUN source $LSST_DIR/loadLSST.bash \
    && eups distrib install lsst_sims `eups distrib list lsst_sims | awk '{print $3}'` \
    && curl -sSL $SHEBANGTRON_URL | python

WORKDIR ${WORKDIR}

USER lsst

# Install the lsst_sims and needed packages
RUN source ${WORKDIR}/loadLSST.bash \
    && conda install -y scikit-image

# Set the default environment
WORKDIR $LSST_USER_HOME
