set nocompatible

syntax on

set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set nobackup
set backupcopy=yes
set nowrap
set tw=0
set shell=/bin/bash

set cinoptions=>4,+8,(8,u0
call pathogen#infect()

" because Y being yy is stupid
map Y y$

" kill any trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" searching
set incsearch                 " incremental search
set hlsearch                  " highlighting when searching

" netrw can go die in a fire
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" this should get best indenting for most common filetypes
filetype indent plugin on
" note: cindent and smartindent do the wrong thing with e.g. indented lines
" starting with # in certain files.
" so i think autoindent is more minimal and good default for all filetypes.
" again, most files will be covered by the previous line.
set autoindent

set bg=dark
set backspace=indent,eol,start

" display
set nolist                    " show/hide tabs and EOL chars
set nonumber                  " show/hide line numbers (nu/nonu)
set scrolloff=5               " scroll offsett, min lines above/below cursor
set scrolljump=5              " jump 5 lines when running out of the screen
set sidescroll=10             " minumum columns to scroll horizontally
set showcmd                   " show command status
set showmatch                 " flashes matching paren when one is typed
set showmode                  " show editing mode in status (-- INSERT --)
set ruler                     " show cursor position

" other
set noerrorbells              " no bells in terminal
set undolevels=1000           " number of undos stored
set history=50		          " keep 50 lines of command line history
set viminfo='50,"50           " '=marks for x files, "=registers for x files

" splice
let g:splice_prefix = ","

" syntastic
let g:loaded_syntastic_jsonnet_jsonnet_checker = 1
let g:jsonnet_fmt_on_save = 0
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_mode_map={ 'mode': 'active',
                         \ 'active_filetypes': ['python', 'coffee'],
                         \ 'passive_filetypes': ['latex'] }
nnoremap <Leader>e :Errors<CR>

" scratch buffers
nnoremap <Leader>v :Vscratch<CR>
nnoremap <Leader>h :Sscratch<CR>

" quickfix
nnoremap <C-J> :cn<CR>
nnoremap <C-K> :cp<CR>

" command t
let g:CommandTFileScanner = 'git'
