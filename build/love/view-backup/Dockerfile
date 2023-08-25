FROM alpine:3.18

ENV PGHOST='localhost'
ENV PGPORT='5432'
ENV PGDATABASE='postgres'
ENV PGUSER='postgres@postgres'
ENV PGPASSWORD='password'
ENV LOVE_SITE='summit'
ENV AWS_ACCESS_KEY_ID=''
ENV AWS_SECRET_ACCESS_KEY=''
ENV CONVERT_SCRIPT_OPTS=''

ARG UID=73006
ARG GID=73006

LABEL maintainer Michael Reuter <mareuter@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

RUN addgroup --gid ${GID} saluser && \
  adduser -u ${UID} -G saluser --disabled-password -s /bin/bash saluser

RUN apk update && apk add postgresql15-client python3 aws-cli

USER saluser
WORKDIR /home/saluser

COPY create_initial_data_json.py .
COPY make_s3_info.py .
COPY backup_views.sh .

ENTRYPOINT [ "/bin/ash" ]
CMD [ "./backup_views.sh" ]
