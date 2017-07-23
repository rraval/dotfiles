call plug#begin('~/.local/share/nvim/plugged')
Plug 'CITguy/vim-coffee-script'
Plug 'VundleVim/Vundle.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'flazz/vim-colorschemes'
Plug 'google/vim-jsonnet'
Plug 'gregsexton/MatchTag'
Plug 'groenewege/vim-less'
Plug 'mtscout6/vim-cjsx'
Plug 'scrooloose/syntastic'
Plug 'sjl/splice.vim'
Plug 'tpope/vim-fugitive'
Plug 'wincent/command-t', {'do': 'cd ruby/command-t/ext/command-t; and ruby extconf.rb; and make'}
call plug#end()

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

" kill any trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Jump to last cursor position, see :help last-position-jump
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" netrw can go die in a fire
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" splice
let g:splice_prefix = ","

" syntastic
let g:loaded_syntastic_jsonnet_jsonnet_checker = 1
let g:jsonnet_fmt_on_save = 0
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_mode_map={ 'mode': 'active',
                         \ 'active_filetypes': ['python', 'coffee'],
                         \ 'passive_filetypes': ['latex'] }

" camel case motion
call camelcasemotion#CreateMotionMappings(',')

" quickfix
nnoremap <Leader>w :terminal<CR>
nnoremap <C-J> :cn<CR>
nnoremap <C-K> :cp<CR>

" command t
let g:CommandTFileScanner = 'git'

" terminal
autocmd TermOpen * set bufhidden=hide
tnoremap <Esc> <C-\><C-n>
tnoremap <A-w> <C-\><C-n><C-w>c
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-w> <C-w>c
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
