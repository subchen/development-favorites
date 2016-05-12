#!/bin/bash

cat > /etc/yum.repos.d/aliyun-7-yum.repo << EOF
[aliyun-7-base]
name=aliyun-7-base
baseurl=http://mirrors.aliyun.com/centos/7/os/x86_64/
enabled=1
gpgcheck=0

[aliyun-7-updates]
name=aliyun-7-updates
baseurl=http://mirrors.aliyun.com/centos/7/updates/x86_64/
enabled=1
gpgcheck=0

[aliyun-7-extras]
name=aliyun-7-extras
baseurl=http://mirrors.aliyun.com/centos/7/extras/x86_64/
enabled=1
gpgcheck=0

[aliyun-7-plus]
name=aliyun-7-plus
baseurl=http://mirrors.aliyun.com/centos/7/centosplus/x86_64/
enabled=1
gpgcheck=0
EOF

cat > /usr/bin/yum-aliyun << EOF
#!/bin/sh
exec yum --disablerepo=* --enablerepo=aliyun-7-* \$*
EOF

chmod +x /usr/bin/yum-aliyun
