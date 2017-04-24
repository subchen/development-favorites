#!/bin/sh

set -e

DSF_VERSION=0.11.4

echo "Downloading diff-so-fancy-${DSF_VERSION}.tar.gz ..."
 && proxy-sh curl -fSL https://github.com/so-fancy/diff-so-fancy/archive/v${DSF_VERSION}.tar.gz -o diff-so-fancy.tar.gz \
 && tar -zxf diff-so-fancy.tar.gz -C /usr/share/ \
 && rm -f diff-so-fancy.tar.gz \
 && ln -sf /usr/share/diff-so-fancy-${DSF_VERSION}/diff-so-fancy /usr/local/bin/

git config --global alias.dsf '!f() { [ -z "$GIT_PREFIX" ] || cd "$GIT_PREFIX" && git diff --color "$@" | diff-so-fancy | less --tabs=4 -RFX; }; f'
