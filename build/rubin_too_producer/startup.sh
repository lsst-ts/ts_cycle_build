#!/usr/bin/env bash

file_path="${HOME}/.config/hop/auth.toml"  # Replace with the actual file path

while [ ! -f "$file_path" ]; do
  echo "File '$file_path' does not exist yet. Sleeping..."
  sleep 5  # Sleep for 5 seconds, adjust as needed
done

python3.12 /usr/src/rubin-ToO-producer/forward_alerts.py -f ${HOME}/config.yaml

