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

# Expose port
EXPOSE 8000

# Set env variables for runtime (to be replaced in docker-compose files)
ENV ADMIN_USER_PASS=test
ENV USER_USER_PASS=test
ENV CMD_USER_PASS=test
ENV NO_DEBUG=True

# Run uvicorn server in runtime
COPY --chown=saluser:saluser startup.sh /home/saluser/.startup.sh
COPY --chown=saluser:saluser init-db.sh /home/saluser/.init-db.sh
RUN chmod a+x /home/saluser/.startup.sh /home/saluser/.init-db.sh
