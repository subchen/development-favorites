#!/bin/bash

set -e

if [ `id -u` != 0 ]; then
  echo "Please run this script under root"
  exit 1
fi

yum install -y git vim zip unzip tree net-tools psmisc bind-utils

systemctl disable iptables-services firewalld

setenforce 0
cat > /etc/sysconfig/selinux << EOF
SELINUX=disabled
SELINUXTYPE=targeted
EOF


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

" no auto comments on next line
set formatoptions-=c formatoptions-=r formatoptions-=o

" highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=brown ctermfg=black

" highlight trailing whitespace
hi TrailingWhitespace ctermbg=red
match TrailingWhitespace /\s\+$/
EOF

cat > ~/.gitconfig << EOF
[push]
    default = simple
[user]
    name = Guoqiang Chen
    email = subchen@gmail.com
[color]
    ui = true
EOF


cat >> ~/.bashrc << EOF
# git branch on bash prompt
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='[\\u@\\h \\w]\\e[1;35m\$(__git_ps1)\\e[m# '
EOF

source ~/.bashrc

