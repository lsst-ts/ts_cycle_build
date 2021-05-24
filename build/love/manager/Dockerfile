# Clone repo
FROM alpine/git as cloner

WORKDIR /usr/src/love
ARG love_manager
RUN git clone --branch ${love_manager} --depth 1 --single-branch https://github.com/lsst-ts/LOVE-manager.git

FROM python:3.8.2-buster
COPY --from=cloner /usr/src/love/LOVE-manager /usr/src/love/

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    libsasl2-dev \
    python-dev \
    libldap2-dev \
    libssl-dev &&\
    rm -rf /var/lib/apt/lists/*

# Set workdir and install python requirements
WORKDIR /usr/src/love/manager

RUN pip install -r requirements.txt

RUN python manage.py collectstatic --noinput

# Expose static files and port
VOLUME /usr/src/love/manager/static
VOLUME /usr/src/love/manager/media
EXPOSE 8000

# Set env variables for runtime (to be replaced in docker-compose files)
ENV ADMIN_USER_PASS=test
ENV USER_USER_PASS=test
ENV CMD_USER_PASS=test
ENV NO_DEBUG=True

# Run daphne server in runtime
CMD ["./runserver.sh"]
