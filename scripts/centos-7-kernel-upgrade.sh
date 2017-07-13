#!/bin/bash

rpm -import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

# kernel-lt（lt=long-term), for centos 5,6
# yum –enablerepo=elrepo-kernel install -y kernel-lt

# kernel-ml（ml=mainline）for centos 7
yum --enablerepo=elrepo-kernel install -y kernel-ml


#
# 手动设置默认内核启动：
#
# 1. 首先找到新版内核的 menuentry 完整字符串.
#     grep menuentry /boot/grub2/grub.cfg
# 2. 设置 "CentOS Linux (4.3.3-1.el7.elrepo.x86_64) 7 (Core)" 作为默认的启动项
#     grub2-set-default "CentOS Linux (4.3.3-1.el7.elrepo.x86_64) 7 (Core)"
# 3. 验证默认启动项
#     grub2-editenv list
# 4. 重启生效
#

# 
# 自动设置默认内核启动：
#
kernel=$(rpm -ql kernel-ml | grep '^/boot/vmlinuz' | sort --version-sort | tail --lines=1)
grubby --set-default=$kernel
