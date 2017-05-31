" vim: set sw=4 ts=4 sts=4 et tw=80 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"

" ===================================
" General
" ===================================
set nocompatible        " Must be first line
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
set backspace=2         " Backspace deletes char in insert mode
set history=3000
set novisualbell             "don't beep
set noerrorbells             "don't beep

syntax on
filetype on

" Visual
set t_Co=256            " Support 256 colors
set background=dark
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
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set clipboard+=unnamed          " Yanks go on clipboard instead.

" Backup
set nowritebackup
set nobackup

set autoread    " auto load if file updated
set autowrite   " auto save when :make

" Match and search
set hlsearch        " Highlight search
set incsearch       " Instant Search
set ignorecase      " Do case in sensitive matching with
set smartcase       " Be sensitive when there's a capital letter

" Formatting
set nowrap
set textwidth=0             " Don't wrap lines by default

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab       " Make tabs into spaces (set by tabstop)
set smarttab

set autoindent

" Highlight current line
set cursorline
highlight CursorLine cterm=NONE ctermbg=DarkYellow ctermfg=Black
autocmd WinEnter * set cursorline
autocmd WinLeave * set nocursorline

" Highlight trailing whitespace (replaced by bronson/vim-trailing-whitespace)
"highlight TrailingWhitespace ctermbg=Red
"match TrailingWhitespace /\s\+$/


" ------------------------------------
" Key mappings
" ------------------------------------
" The default leader is '\', but many people prefer ','
let mapleader = ','

" :Q equals q to exit vim
command! -bang Q q<bang>

" :W sudo saves the file (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

noremap <silent> <F12>e :e ~/.vimrc<CR>
noremap <silent> <F12>r :source ~/.vimrc<CR>

noremap <silent> <F2> :set number!<CR>

" Toggle between paste and normal: to safe pasting from keyboard
set pastetoggle=<F11>

" Tab option
noremap <silent> <leader>tn :tabnew<CR>
noremap <silent> <leader>tp :tabprev<CR>
noremap <silent> <leader>tn :tabnext<CR>

" Default keys for windows
"noremap <silent> <C-W>n :new<CR>
"noremap <silent> <C-W>v :vnew<CR>

" Buffers
noremap <silent> <C-N> :bn<CR>
noremap <silent> <C-B> :bp<CR>

" Code folding options
noremap <silent> <leader>fo :set foldenable foldmethod=syntax<CR>
noremap <silent> <leader>fc :set nofoldenable<CR>
noremap <silent> <leader>f0 :set foldlevel=0<CR>
noremap <silent> <leader>f1 :set foldlevel=1<CR>
noremap <silent> <leader>f2 :set foldlevel=2<CR>
noremap <silent> <leader>f3 :set foldlevel=3<CR>
noremap <silent> <leader>f4 :set foldlevel=4<CR>
noremap <silent> <leader>f5 :set foldlevel=5<CR>
noremap <silent> <leader>f6 :set foldlevel=6<CR>
noremap <silent> <leader>f7 :set foldlevel=7<CR>
noremap <silent> <leader>f8 :set foldlevel=8<CR>
noremap <silent> <leader>f9 :set foldlevel=9<CR>

" ------------------------------------
" filetype detect
" ------------------------------------
" noexpandtab for special filetypes
autocmd FileType makefile set ts=4 sw=4 noexpandtab


" ===================================
" Bundle plugins (vundle)
"   $ mkdir -p ~/.vim/bundle/
"   $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" ===================================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/ZoomWin'
Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'mbriggs/mark.vim'
Plugin 'tpope/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'fatih/vim-go'
" Plugin 'Valloric/YouCompleteMe'

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
noremap <silent> <F4> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 30
let g:NERDTreeDirArrows = 0             " Use Arrows or '+,-,|'
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeIgnore = [
    \ '\.pyc$', '\.pyo$',
    \ '\.obj$', '\.o$', '\.so$',
    \ '^\~\$', '\.swp$',
    \ '\.DS_Store$',
    \ '^\.idea$',
    \ '^\.git$', '^\.svn$', '^\.hg$'
    \ ]

let g:NERDTreeIndicatorMapCustom = {
    \ 'Modified'  : '*',
    \ 'Staged'    : '+',
    \ 'Untracked' : '-',
    \ 'Renamed'   : '>',
    \ 'Unmerged'  : '═',
    \ 'Deleted'   : 'x',
    \ 'Dirty'     : '*',
    \ 'Clean'     : 'o',
    \ 'Ignored'   : '!',
    \ 'Unknown'   : '?'
    \ }

" ------------------------------------
"   ctrlp
" ------------------------------------
noremap <silent> <F3> :CtrlP<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
let g:ctrlp_working_path_mode = 'rw'

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
"   tagbar
" ------------------------------------
noremap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_left = 0
let g:tagbar_expand = 1
let g:tagbar_compact = 1
let g:tagbar_singleclick = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30

" ------------------------------------
"   ag.vim
" ------------------------------------
let g:ag_prg = 'ag --vimgrep --smart-case'
let g:ag_working_path_mode = 'r'    " Search from project root

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
"   vim-colorschemes and base16-vim
"   review:    http://vimcolors.com/
"   customize: http://bytefluent.com/vivify/
" ------------------------------------
set t_Co=256          " Support 256 colors
set background=dark
colorscheme Tomorrow-Night-Eighties
" colorscheme molokai
" colorscheme evening

" ------------------------------------
"   vim-airline & vim-airline-themes
" ------------------------------------
let g:airline_theme = 'tomorrow'        " Default is same with colorscheme
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" ------------------------------------
"   mark.vim
" ------------------------------------
nmap <silent> <leader>, <Plug>MarkSearchCurrentPrev
nmap <silent> <leader>. <Plug>MarkSearchCurrentNext
" Usage (default)
"  <leader>m    " mark/unmark a word
"  <leader>*    " goto next current marked word
"  <leader>#    " goto prev current marked word
"  <leader>/    " goto next marked work
"  <leader>?    " goto prev marked work
"

" ------------------------------------
"   vim-markdown
" ------------------------------------
let g:markdown_fenced_languages = ['html', 'js', 'css', 'python', 'java', 'go', 'bash=sh']
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

" ------------------------------------
"   vim-json
" ------------------------------------
let g:vim_json_syntax_conceal = 0

" :JsonFormat
command! JsonFormat :execute '%!python -m json.tool'

" ------------------------------------
"   go-vim
" ------------------------------------
" Install
"   :GoInstallBinaries
"
let g:go_fmt_command = 'goimports'
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1


" ------------------------------------
"   YouCompleteMe
" ------------------------------------
" Install: requires Vim 7.4.1578+
"   $ yum install -y install automake gcc gcc-c++ kernel-devel cmake make python-devel
"   $ cd ~/.vim/bundle/YouCompleteMe
"   $ ./install.py --all
"
