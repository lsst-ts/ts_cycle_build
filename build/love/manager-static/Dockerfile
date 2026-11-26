ARG cycle=develop
FROM ts-dockerhub.lsst.org/deploy-env:${cycle}

ARG love_manager

LABEL maintainer="Sebastian Aranda <sebastian.aranda@noirlab.edu>"

RUN source /home/saluser/.setup_sal_env.sh && \
	conda install -y -c lsstts \
    "$(conda_package_spec love-manager "${love_manager}")"

# Create static and media files folder
USER root
RUN mkdir /usr/src/love-manager
RUN chown saluser:saluser /usr/src/love-manager
USER saluser

# Expose static and media files
VOLUME /usr/src/love-manager

# Set env variables for runtime (to be replaced in docker-compose files)
ENV ADMIN_USER_PASS=test
ENV USER_USER_PASS=test
ENV CMD_USER_PASS=test
ENV NO_DEBUG=True

# Run static and media files collection
COPY --chown=saluser:saluser startup.sh /home/saluser/.startup.sh
RUN chmod a+x /home/saluser/.startup.sh
