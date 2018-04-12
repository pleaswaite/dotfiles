set nocompatible  "don't worry about being compatible with old school vim

set modelines=0 "prevent some security holes

set titlestring=%f title "make filename title of terminal

" tabs == 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set smarttab "autoindent when it makes sense

set ignorecase "don't care about caps for searching
set smartcase "ignore ignorecase when it makes sense

set number "we like line numbers in our file...
set relativenumber "so we display absolute number of current
									 "line and the relative numbers around it
set ruler "and columnn numbers, too

set nowrap "don't wrap text

set scrolloff=4 "leave at least 4 lines of context above and below a scroll
set ttyfast "redraw faster to scroll smoother

set history=5001 "I like to see what I did forever ago
set undolevels=5001 "and to undo what I did forever ago...

set nrformats=alpha

syntax enable "turn on syntax highlighting

set background=dark "because..dark is the new black

"Custom bindings
"stop hitting help accidentally
inoremap <F1> <ESC>
"let us turn on relative line numbers with F1
nnoremap <F1> :set rnu<cr>
vnoremap <F1> :set rnu<cr>
"let us turn on absolute line numbers with F2
nnoremap <F2> :set nu<cr>
vnoremap <F2> :set nu<cr>
"let us turn off line numbers with F3
nnoremap <F3> :set nonu<cr>
vnoremap <F3> :set nonu<cr>
"less hand movement to get out of insert mode
"note: hh is right under the homerow for us dvorak users
inoremap hh <ESC>
"quick write with ss
vnoremap ss :w<cr> 
nnoremap ss :w<cr>
"insert date/timestamp into line and switch to insert mode
"handy for logging crap during incidents... 
vnoremap <F4> :r!date<cr>A<cr>
inoremap <F4> <ESC>:r!date<cr>A<cr>
nnoremap <F4> :r!date<cr>A<cr>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"Special stuff for Python
autocmd Filetype python set expandtab "Break tab chars into spaces
if exists('+colorcolumn')
	autocmd Filetype python set cc=80	"Colorize the 80th column
endif

execute pathogen#infect()
