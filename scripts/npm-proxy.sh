#!/bin/bash

cat > /usr/bin/npm-taobao << EOF
#!/bin/bash
exec npm --registry=https://registry.npm.taobao.org \$*
EOF

chmod +x /usr/bin/npm-taobao

cat > /usr/bin/npm-cn << EOF
#!/bin/bash
exec npm --registry=http://registry.cnpmjs.org \$*
EOF

chmod +x /usr/bin/npm-cn
