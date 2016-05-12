#!/bin/sh

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
