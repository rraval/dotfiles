call plug#begin('~/.local/share/nvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'bkad/CamelCaseMotion'
Plug 'groenewege/vim-less'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'lfv89/vim-interestingwords'
Plug 'mhinz/vim-startify'
Plug 'mtscout6/vim-cjsx'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'sjl/splice.vim'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-fugitive'
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

" stop autoindenting things as I type
autocmd FileType python setlocal indentkeys-=<:>

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

" session management
let g:startify_disable_at_vimenter = 1
nnoremap <Leader>s :SSave! default<CR>:SClose<CR>
nnoremap <Leader>a :SLoad default<CR>

" arc
nnoremap <Leader>z :cexpr system("arc lint --output=compiler")<CR>

" prevent nested nvim's
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

" firenvim, firefox integration
let g:firenvim_config = {
    \ 'localSettings': {
        \ '.*': {
            \ 'priority': 0,
            \ 'takeover': 'never',
        \ },
    \ }
\ }
