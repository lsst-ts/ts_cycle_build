# Clone repo
FROM alpine/git as cloner

WORKDIR /usr/src/

RUN git clone https://github.com/scimma/rubin-ToO-producer.git

FROM almalinux:9.5

WORKDIR /usr/src/

ARG UID=73006
ARG GID=73006

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

RUN groupadd --gid ${GID} saluser && \
  adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

RUN dnf install -y python3.12 python3.12-pip

COPY --from=cloner --chown=${USER}:${USER} /usr/src/rubin-ToO-producer /usr/src/rubin-ToO-producer

USER ${USER}

WORKDIR /usr/src/rubin-ToO-producer

RUN pip3.12 install -r requirements.txt

COPY --chown=${USER}:${USER} --chmod=755 startup.sh /home/saluser/.startup.sh

ENTRYPOINT ["/home/saluser/.startup.sh"]
