#!/bin/bash

cat > /etc/yum.repos.d/netease-7-yum.repo << EOF
[netease-7-base]
name=netease-7-base
baseurl=http://mirrors.163.com/centos/7/os/x86_64/
enabled=1
gpgcheck=0

[netease-7-updates]
name=netease-7-updates
baseurl=http://mirrors.163.com/centos/7/updates/x86_64/
enabled=1
gpgcheck=0

[netease-7-extras]
name=netease-7-extras
baseurl=http://mirrors.163.com/centos/7/extras/x86_64/
enabled=1
gpgcheck=0

[netease-7-plus]
name=netease-7-plus
baseurl=http://mirrors.163.com/centos/7/centosplus/x86_64/
enabled=1
gpgcheck=0
EOF

cat > /usr/bin/yum-163 << EOF
#!/bin/sh
exec yum --disablerepo=* --enablerepo=netease-7-* \$*
EOF

chmod +x /usr/bin/yum-163
