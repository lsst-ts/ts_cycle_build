#!/usr/bin/env bash

file_path="${HOME}/.config/hop/auth.toml"

cat > "$file_path" <<EOF
[[auth]]
username = "$SCIMMA_USERNAME"
password = "$SCIMMA_PASSWD"
protocol = "SASL_SSL"
mechanism = "SCRAM-SHA-512"
EOF

chmod 0600 $file_path

python3.12 /usr/src/rubin-ToO-producer/forward_alerts.py -f ${HOME}/config.yaml

