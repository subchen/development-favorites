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
colorscheme default

set number
set showmatch           " Show matching brackets
set ruler
set modeline
set laststatus=2        " Show statusbar
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
highlight CursorLine cterm=NONE ctermbg=DarkYellow ctermfg=Black

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=Red
match TrailingWhitespace /\s\+$/


" ------------------------------------
" Key mappings
" ------------------------------------
let mapleader = ","

noremap <silent> <F12>e :tabnew ~/.vimrc<CR>
noremap <silent> <F12>r :source ~/.vimrc<CR>

noremap <silent> <F12>t :tabnew<CR>
noremap <silent> <F12>[ :tabprev<CR>
noremap <silent> <F12>] :tabnext<CR>

noremap <silent> <F12>w :new<CR>
noremap <silent> <F12>v :vnew<CR>

noremap <silent> <F12>fo :set foldenable foldmethod=syntax<CR>
noremap <silent> <F12>fc :set nofoldenable<CR>

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
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/ZoomWin'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'chriskempson/base16-vim'
Plugin 'fatih/vim-go'
"Plugin 'Valloric/YouCompleteMe'

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
noremap <F4> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
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
"   ctrlp
" ------------------------------------
noremap <F3> :CtrlP<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }

" Usage
"   <C-P> or :CtrlP " Start to search
"   Press <F5> to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.
"   Press <c-f> and <c-b> to cycle between modes.
"   Press <c-d> to switch to filename only search instead of full path.
"   Press <c-r> to switch to regexp mode.
"   Use <c-j>, <c-k> or the arrow keys to navigate the result list.
"   Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
"   Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
"   Use <c-y> to create a new file and its parent directories.
"   Use <c-z> to mark/unmark multiple files and <c-o> to open them.
"

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

" ------------------------------------
"   ZoomWin
" ------------------------------------
" Usage
"   <C-W>o  " toggle full window
"

" ------------------------------------
"   vim-airline & vim-airline-themes
" ------------------------------------
let g:airline_theme='hybrid'

" ------------------------------------
"   base16-vim
" ------------------------------------
" Usage
"   :colorscheme base16-default
"

" ------------------------------------
"   go-vim
" ------------------------------------
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

" Install
"   :GoInstallBinaries
"

" ------------------------------------
"   YouCompleteMe
" ------------------------------------
" Install manual
"   $ yum install -y install automake gcc gcc-c++ kernel-devel cmake make python-devel
"   $ cd ~/.vim/bundle/YouCompleteMe
"   $ ./install.py --all
"
