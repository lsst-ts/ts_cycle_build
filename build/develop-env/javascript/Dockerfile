FROM almalinux:9

ARG UID=73006
ARG GID=73006

ENV USER=saluser
ENV HOME=/home/saluser
ENV STACKDIR=/opt/lsst/software/stack
ENV WORKDIR=${STACKDIR}

USER root

RUN dnf install -y gcc libatomic

RUN groupadd --gid ${GID} ${USER} && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash ${USER} 

USER saluser
# Use bash for the shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create a script file sourced by both interactive and non-interactive bash shells
ENV BASH_ENV=$HOME/.bash_env
RUN touch "${BASH_ENV}"
RUN echo '. "${BASH_ENV}"' >> ${HOME}/.bashrc
WORKDIR ${HOME}

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Download and install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | PROFILE="${BASH_ENV}" bash
RUN echo node > $HOME/.nvmrc
RUN nvm install
RUN uv tool install pre-commit
