#!/bin/bash

rpm -import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

# kernel-lt（lt=long-term）
yum –enablerepo=elrepo-kernel install -y kernel-lt

# kernel-ml（ml=mainline）
# yum –enablerepo=elrepo-kernel install -y kernel-ml

echo
echo "Please reload your host to take effect."
echo
