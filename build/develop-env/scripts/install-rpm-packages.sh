#!/usr/bin/env bash

set -Eeuo pipefail

if [[ $# -ne 1 || ( "$1" != stack && "$1" != no-stack ) ]]; then
    echo "Usage: $0 stack|no-stack" >&2
    exit 2
fi

case "$1" in
    stack)
        packages=(
            automake bzip2 diffutils dos2unix emacs file gdb gettext-devel
            glibc-devel gnome-terminal graphviz iproute libexif LibRaw libtool
            libtool-ltdl-devel libusbx-devel ltrace mariadb mariadb-devel nano
            ncurses-libs net-tools popt-devel strace swig tcpdump tk tk-devel tzdata
            unzip zip which xorg-x11-fonts-misc xterm epel-release freeglut-devel
            mesa-dri-drivers
        )
        ;;
    no-stack)
        packages=(
            git git-lfs make wget pkg-config libgphoto2-devel gcc
            xorg-x11-server-Xvfb
        )
        ;;
esac

dnf install -y yum-utils
dnf config-manager --set-enabled crb
dnf install -y "${packages[@]}"
dnf clean all
rm -rf /var/cache/dnf
