#!/bin/sh

set -e

mkdir -p ~/.ssh

cat >> ~/.ssh/authorized_keys << EOF
...
EOF

cat >  ~/.ssh/id_rsa << EOF
-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----
EOF

cat > ~/.ssh/id_rsa.pub << EOF
...
EOF

chmod 0600 ~/.ssh/id_rsa
chmod 0644 ~/.ssh/id_rsa.pub

