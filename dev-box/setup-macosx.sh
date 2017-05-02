#!/bin/bash

set -e
set -x

# install brew and brew-cask
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
brew install caskroom/cask/brew-cask

# basic tools
brew install \
    openssh-ssl ssh-copy-id sshfs \
    git wget vim curl md5sha1sum coreutils pcre \
    the_silver_searcher jq yajl

ln -sf /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# sshpass
brew install https://raw.github.com/eugeneoden/homebrew/eca9de1/Library/Formula/sshpass.rb

