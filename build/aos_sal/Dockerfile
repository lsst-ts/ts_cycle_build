# Dockerfile to execute a base machine with all set to test active optics
# system software

ARG base_image_tag

FROM lsstts/develop-env:${base_image_tag}

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/$LSST_USER
ARG LSST_DIR=/opt/lsst/software/stack
ARG SHEBANGTRON_URL=https://raw.githubusercontent.com/lsst/shebangtron/master/shebangtron

USER root

# Install the required packages
RUN yum install -y csh \
    && yum clean all \
    && rm -rf /var/cache/yum

# Set the default user of container
USER $LSST_USER

# Install the lsst_sims and needed packages
RUN source $LSST_DIR/loadLSST.bash \
    && eups distrib install lsst_sims `eups distrib list lsst_sims | awk '{print $3}'` \
    && curl -sSL $SHEBANGTRON_URL | python \
    && conda install -y scikit-image

# Install the plantUML
WORKDIR $LSST_USER_HOME
RUN source $LSST_DIR/loadLSST.bash \
    && wget https://newcontinuum.dl.sourceforge.net/project/plantuml/plantuml.jar \
    && pip install sphinxcontrib-plantuml

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
