#!/usr/bin/env bash

# Source this file when starting the container to set it up

source /opt/lsst/software/stack/loadLSST.bash

# Needed for Python-GPhoto2
export LDFLAGS="-L/usr/local/lib -L/usr/local/lib/libgphoto2/${gphoto2} -L/usr/local/lib/libgphoto2_port/0.12.0"

# Suppress several OpenGL warnings
export LIBGL_ALWAYS_INDIRECT=1

# Needed for PySide6
export QT_API="PySide6"
export PYTEST_QT_API="PySide6"

export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:$CONDA_PREFIX/share/pkgconfig:$CONDA_PREFIX/lib/pkgconfig
