# Clone repo
FROM alpine/git as cloner

WORKDIR /usr/src/love
ARG love_manager
RUN git clone --branch ${love_manager} --depth 1 --single-branch https://github.com/lsst-ts/LOVE-manager.git || git clone --branch v${love_manager} --depth 1 --single-branch https://github.com/lsst-ts/LOVE-manager.git

FROM python:3.11-bookworm as builder
COPY --from=cloner /usr/src/love/LOVE-manager /usr/src/love

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    libsasl2-dev \
    libldap2-dev \
    libssl-dev &&\
    rm -rf /var/lib/apt/lists/*

# Set workdir and install python requirements
WORKDIR /usr/src/love/manager
RUN pip install -r requirements.txt

WORKDIR /usr/src/love/manager
RUN find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
RUN python manage.py collectstatic --noinput

# Copy media data
RUN mkdir -p media/thumbnails
RUN cp -u ui_framework/fixtures/thumbnails/* media/thumbnails
RUN mkdir -p media/configs
RUN cp -u api/fixtures/configs/* media/configs

# copy compiled files to smaller image
FROM alpine:3.8
COPY --from=builder /usr/src/love/manager/static /usr/src/love/manager/static
COPY --from=builder /usr/src/love/manager/media /usr/src/love/manager/media
VOLUME /usr/src/love/manager/static
VOLUME /usr/src/love/manager/media
