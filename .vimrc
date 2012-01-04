set nocompatible

set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" use haskell highlighting on hsc files
autocmd BufNewFile,BufRead *.hsc set ft=haskell
autocmd BufNewFile,BufRead *.cabal set ft=cabal
autocmd BufNewFile,BufRead *.txt set ft=text
autocmd BufNewFile,BufRead README set ft=text

autocmd FileType python set autoindent | set softtabstop=4
autocmd FileType make set noexpandtab | set tabstop=8 | set shiftwidth=8
autocmd FileType text set tw=78

" kill any trailing whitespace on save
autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text
  \ autocmd BufWritePre <buffer>
  \ :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

autocmd FileType php setlocal iskeyword+=$
set tags=tags;/

" searching
set incsearch                 " incrimental search
set hlsearch                  " highlighting when searching

" this should get best indenting for most common filetypes
filetype indent plugin on
" note: cindent and smartindent do the wrong thing with e.g. indented lines
" starting with # in certain files.
" so i think autoindent is more minimal and good default for all filetypes.
" again, most files will be covered by the previous line.
set autoindent

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
set viminfo='50,"50           " '=marks for x files, "=registers for x files

"
" things you may be interested in for your .vimrc
"

" highlight literal tabs
match Error '\t'

" bind "gb" to "git blame" for visual and normal mode.
:vmap gb :<C-U>!git blame % -L<C-R>=line("'<") <CR>,<C-R>=line("'>") <CR><CR>
:nmap gb :!git blame %<CR>
