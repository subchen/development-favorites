#!/bin/bash

rpm -import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

# kernel-lt（lt=long-term), for centos 5,6
# yum –enablerepo=elrepo-kernel install -y kernel-lt

# kernel-ml（ml=mainline）for centos 7
yum --enablerepo=elrepo-kernel install -y kernel-ml

echo
echo "Please reload your host to take effect."
echo
