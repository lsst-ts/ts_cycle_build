ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Wouter van Reeven <wvanreeven@lsst.org>

ARG genericcamera
ARG config
ARG gphoto2

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

WORKDIR /home/saluser/ts_config_ocs

RUN /home/saluser/.checkout_repo.sh ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV RUN_ARG=""

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh

RUN yum -y --enablerepo=extras install make \
  libtool-ltdl-devel \
  libtool \
  automake \
  libusb-devel \
  popt-devel \
  gettext-devel \
  libexif-devel \
  LibRaw-devel \
  bzip2 \
  file

# Install GPhoto2
WORKDIR /tmp
RUN curl -sSL https://github.com/gphoto/libgphoto2/releases/download/v${gphoto2}/libgphoto2-${gphoto2}.tar.bz2 -o libgphoto2-${gphoto2}.tar.bz2 && \
    tar jxf libgphoto2-${gphoto2}.tar.bz2 && \
    cd libgphoto2-${gphoto2} && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install && \
# Copy the .pc files so pkg-config can find them later on
    cp libgphoto2.pc /usr/share/pkgconfig && \
    cp libgphoto2_port/libgphoto2_port.pc /usr/share/pkgconfig && \
    echo "/usr/local/lib" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2/${gphoto2}" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2_port/0.12.0" >> /etc/ld.so.conf.d/gphoto2.conf && \
    ldconfig

# Install LibGPhoto2
WORKDIR /tmp
RUN curl -sSL https://github.com/gphoto/gphoto2/releases/download/v${gphoto2}/gphoto2-${gphoto2}.tar.bz2 -o gphoto2-${gphoto2}.tar.bz2 && \
    tar jxf gphoto2-${gphoto2}.tar.bz2 && \
    cd gphoto2-${gphoto2} && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install

USER saluser

# Needed for Python-GPhoto2
RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -y swig pillow tornado && \
    pip install Pillow rawpy

# Install Python-GPhoto2
WORKDIR /tmp
RUN source /home/saluser/.setup_sal_env.sh && \
    git clone https://github.com/jim-easterbrook/python-gphoto2.git && \
    cd python-gphoto2 && \
    python setup.py build_swig && \
    python setup.py build && \
    python setup.py install

RUN source /home/saluser/.setup_sal_env.sh && \
    conda install -c lsstts ts-genericcamera=${genericcamera}

LABEL ts-genericcamera=${genericcamera} \
      ts_config_ocs=${config}
