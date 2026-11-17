#!/bin/bash

source /home/saluser/.setup_sal_env.sh
PKG_DIR=$(python -c "import importlib.resources; print(importlib.resources.files('love.manager'))")

if [ -z ${LOVE_SITE} ]; then
  love_site="summit"
else
  love_site=${LOVE_SITE}
fi
echo -e "\nSite: ${love_site}"

echo -e "\nGenerating static files to be served..."
manage_love collectstatic --noinput

echo -e "\nGenerating media files to be served..."
mkdir -p /usr/src/love-manager/media/thumbnails
cp -u ${PKG_DIR}/ui_framework/fixtures/thumbnails/* /usr/src/love-manager/media/thumbnails
if [ -d "${PKG_DIR}/ui_framework/fixtures/thumbnails/${love_site}" ]; then
  cp -u ${PKG_DIR}/ui_framework/fixtures/thumbnails/${love_site}/* /usr/src/love-manager/media/thumbnails
fi
mkdir -p /usr/src/love-manager/media/configs
cp -u ${PKG_DIR}/api/fixtures/configs/* /usr/src/love-manager/media/configs
