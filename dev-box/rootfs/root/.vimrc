" ===================================
" General
" ===================================
set nocompatible
set encoding=utf-8
set fileformat=unix

syntax on
filetype on

" Visual
set background=light
set number
set showmatch           " Show matching brackets
set ruler
set modeline
set laststatus=2        " Show status
set cmdheight=2
set showcmd             " Display an incomplete command in the lower right corner of the Vim window:
set showfulltag
set showmode
set imcmdline
set clipboard+=unnamed  " Yanks go on clipboard instead.

" Toggle between paste and normal: to safe pasting from keyboard
set pastetoggle=<F11>

" Backup
set nowritebackup
set nobackup

" Match and search
set hlsearch        " Highlight search
set incsearch       " Instant Search
set ignorecase      " Do case in sensitive matching with
set smartcase       " Be sensitive when there's a capital letter

" Formatting
set nowrap
set textwidth=0             " Don't wrap lines by default
set wildmode=longest,list

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab       " Make tabs into spaces (set by tabstop)
set smarttab

set autoindent

" Highlight current line
set cursorline
highlight CursorLine cterm=NONE ctermbg=brown ctermfg=black

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red
match TrailingWhitespace /\s\+$/


" ------------------------------------
" Key mappings
" ------------------------------------
noremap <silent> <F12>ve :tabnew ~/.vimrc<CR>
noremap <silent> <F12>vr :source ~/.vimrc<CR>

noremap <silent> <F12>tn :tabnew<CR>
noremap <silent> <F12>t[ :tabprev<CR>
noremap <silent> <F12>t] :tabnext<CR>

noremap <silent> <F12>ws :new<CR>
noremap <silent> <F12>wv :vnew<CR>

noremap <silent> <F12>= :set foldenable foldmethod=indent<CR>
noremap <silent> <F12>- :set nofoldenable<CR>

" ------------------------------------
" detect *.go, *.md
" ------------------------------------
autocmd BufRead,BufNewFile {*.go}              set ft=go
autocmd BufRead,BufNewFile {*.md,*.markdown}   set ft=markdown

" noexpandtab for special filetypes
autocmd FileType go       set ts=4 sw=4 noexpandtab
autocmd FileType makefile set ts=4 sw=4 noexpandtab


" ===================================
" Bundle plugins (vundle)
"   $ mkdir -p ~/.vim/bundle/
"   $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" ===================================
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/ZoomWin'
Plugin 'fatih/vim-go'

call vundle#end()
filetype plugin indent on

" Brief help
"   :PluginList       - lists configured plugins
"   :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"   :PluginSearch foo - searches for foo; append `!` to refresh local cache
"   :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ------------------------------------
"   nerdtree & nerdtree-git-plugin
" ------------------------------------
noremap <F12>f :NERDTreeToggle<CR>
let NERDTreeChDirMode=2
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "-",
    \ "Renamed"   : ">",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "*",
    \ "Clean"     : "o",
    \ 'Ignored'   : '!',
    \ "Unknown"   : "?"
    \ }

" ------------------------------------
"   ag.vim
" ------------------------------------
let g:ag_prg="ag --column"
" Usage
"   :Ag [options] {pattern} [{directory}]
"
" In the quickfix window, you can use:
"   o    to open (same as enter)
"   go   to preview file (open but maintain focus on ag.vim results)
"   t    to open in new tab
"   T    to open in new tab silently
"   h    to open in horizontal split
"   H    to open in horizontal split silently
"   v    to open in vertical split
"   gv   to open in vertical split silently
"   q    to close the quickfix window
"
