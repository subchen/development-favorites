#!/bin/bash

set -e

if [ `id -u` != 0 ]; then
  echo "Please run this script under root"
  exit 1
fi

yum install -y git vim zip unzip tree net-tools psmisc bind-utils

cat > ~/.vimrc << EOF
filetype on
syntax on
set encoding=utf-8
set background=light
set tabstop=4
set shiftwidth=4
set number
set expandtab
set showmatch
set ruler
set ignorecase
set hlsearch
set incsearch
set modeline
set showcmd
set showfulltag
set showmode
set smartcase
set imcmdline
set cursorline
hi CursorLine cterm=NONE ctermbg=brown ctermfg=black
EOF

cat > ~/.gitconfig << EOF
[push]
    default = simple
[user]
    name = Guoqiang Chen
[color]
    ui = true
EOF


cat > /etc/bashrc << EOF
# load user definitions
for f in /etc/bashrc.d/*.sh; do
    [ -r "$f" ] && . "$f"
done
EOF

mkdir -p /etc/bashrc.d/

cat > /etc/bashrc.d/alias.sh << EOF
alias ll="ls -l --color"
alias grep="/usr/bin/grep -n --color"
EOF

# take effect right now
. /etc/bashrc.d/alias.sh
