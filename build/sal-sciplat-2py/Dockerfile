ARG input
FROM $input AS base-image
USER 0:0
SHELL ["/bin/bash", "-lc"]

RUN mkdir -p /tmp/build
WORKDIR /tmp/build

# Add other system-level files

# An /etc/passwd

COPY scripts/* /tmp/build/
RUN bash ./make-root-user

RUN bash ./make-user

USER lsst_local:lsst_local

# Do the SAL install

USER root

# SAL install privileged parts
COPY cycle.env /tmp/build/cycle.env
RUN bash ./install-ts-root

USER lsst_local:lsst_local

# SAL install unprivileged parts
RUN bash ./install-ts-user

# Get our manifests.  This has always been really useful for debugging
# "what broke this week?"

RUN bash ./generate-versions

ARG version

# Add T&S tags to image description
RUN . /tmp/build/cycle.env ; \
    [ -n "${CYCLE}" ] && version="${version}_${CYCLE}"; \
    [ -n "${rev}" ] && version="${version}${rev}"

# Clean up.
# This needs to be numeric, since we will remove /etc/passwd and friends
# while we're running.
USER 0:0
WORKDIR /

COPY scripts/cleanup-files .
RUN bash ./cleanup-files
RUN rm ./cleanup-files

# Back to unprivileged
USER 1000:1000
WORKDIR /tmp

CMD ["/usr/local/share/jupyterlab/runlab"]

# Overwrite Stack Container definitions with more-accurate-for-us ones
ENV  DESCRIPTION="Rubin Science Platform Notebook Aspect, SAL edition"
ENV  SUMMARY="Rubin Science Platform Notebook Aspect, SAL edition"

LABEL description="Rubin Science Platform Notebook Aspect, SAL edition: $version" \
       name="sal-sciplat:$version" \
       version="$version"
