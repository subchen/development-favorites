#!/bin/bash

cat > /usr/bin/npm-tb << EOF
#!/bin/bash
exec npm --registry=https://registry.npm.taobao.org \$*
EOF

chmod +x /usr/bin/npm-tb

cat > /usr/bin/npm-cn << EOF
#!/bin/bash
exec npm --registry=http://registry.cnpmjs.org \$*
EOF

chmod +x /usr/bin/npm-cn
