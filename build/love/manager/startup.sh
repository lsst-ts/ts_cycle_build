#!/bin/bash

source /home/saluser/.setup_sal_env.sh
PKG_DIR=$(python -c "import importlib.resources; print(importlib.resources.files('love.manager'))")

echo -e "\nGenerating config media files used by the server..."
mkdir -p /usr/src/love-manager/media/configs
cp -u ${PKG_DIR}/api/fixtures/configs/* /usr/src/love-manager/media/configs

echo -e "\nStarting server"
export PYTHONPATH="$PKG_DIR${PYTHONPATH:+:$PYTHONPATH}"
python -m uvicorn --host 0.0.0.0 --port 8000 manager.asgi:application
