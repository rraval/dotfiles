call plug#begin('~/.local/share/nvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'bkad/CamelCaseMotion'
Plug 'gregsexton/MatchTag'
Plug 'groenewege/vim-less'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'lfv89/vim-interestingwords'
Plug 'mtscout6/vim-cjsx'
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plug 'sjl/splice.vim'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-fugitive'
Plug 'vim-python/python-syntax'
Plug 'vim-syntastic/syntastic'
Plug 'wincent/command-t', {'do': 'cd ruby/command-t/ext/command-t; and ruby extconf.rb; and make'}
call plug#end()

syntax enable
set background=dark
colorscheme solarized

set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set nobackup
set backupcopy=yes
set nowrap
set tw=0
set bg=dark
set scrolloff=5
set scrolljump=5
set sidescroll=10
set showmatch
set showmode
set cinoptions=>4,+8,(8,u0

" because Y being yy is stupid
map Y y$

" editing commands
" Ctrl+D for inserting the current buffer's directory for optin relative editing
cnoremap <expr> <C-d> expand('%:h/') . '/'

" kill any trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Jump to last cursor position, see :help last-position-jump
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" netrw can go die in a fire
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" splice
let g:splice_prefix = ","

" camel case motion
call camelcasemotion#CreateMotionMappings(',')

" quickfix
" automatically put the quickfix window as a fully expanded bottom most split
autocmd FileType qf wincmd J
nnoremap <C-J> :cn<CR>
nnoremap <C-K> :cp<CR>

" command t
let g:CommandTFileScanner = 'git'

" terminal
nnoremap <Leader>w :terminal<CR>
autocmd BufEnter term://* startinsert
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" insert the HEAD commit message
nnoremap <Leader>g :read !git show --pretty='format:\%s\%n\%n\%b' -s<CR>

" prevent nested nvim's
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = []
