set nocompatible

syntax on

set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set nobackup
set tw=0

set cinoptions=>4,+8,(8,u0
call pathogen#infect()

" because Y being yy is stupid
map Y y$

" use haskell highlighting on hsc files
autocmd BufNewFile,BufRead *.hsc set ft=haskell
autocmd BufNewFile,BufRead *.cabal set ft=cabal
autocmd BufNewFile,BufRead *.txt set ft=text
autocmd BufNewFile,BufRead README set ft=text
autocmd FileType make set noexpandtab | set tabstop=8 | set shiftwidth=8

" kill any trailing whitespace on save
autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text
    \ autocmd BufWritePre <buffer>
    \ :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Rebuild tags file with Makefile if possible on write
"autocmd BufWritePost *.py
"    \ silent! execute "!make -C `dirname " . findfile("Makefile","./;") .
"    \ "` tags &> /dev/null &" | redraw!

autocmd FileType php setlocal iskeyword+=$
set tags=tags;/

" searching
set incsearch                 " incrimental search
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

" haskell mode
au BufEnter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/chromium"
let g:haddock_browser_callformat = '%s file://%s >/dev/null &'
let g:haddock_indexfiledir="~/.vim/"

" latexsuite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_CompileRule_pdf='pdflatex $*'

" fugitive
nnoremap <Leader>s :Gstatus<CR>
nnoremap <Leader>c :Gcommit<CR>
nnoremap <Leader>d :Gdiff<CR>
nnoremap <Leader>g :Ggrep<Space>

" syntastic
let g:syntastic_mode_map={ 'mode': 'active',
                         \ 'active_filetypes': ['python', 'coffee'],
                         \ 'passive_filetypes': ['latex'] }
nnoremap <Leader>e :Errors<CR>

" scratch buffers
nnoremap <Leader>v :Vscratch<CR>
nnoremap <Leader>h :Sscratch<CR>

" coffeescript
nnoremap <Leader>w :CoffeeCompile watch vert<CR>
nnoremap <Leader>q :CoffeeCompile unwatch<CR>
