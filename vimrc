" Plugins
filetype plugin on

" Tabulaciones.
set softtabstop=4 shiftwidth=4 expandtab
set autoindent smartindent copyindent
set lcs=tab:→\ 
set list

" Interfaz.
set relativenumber number
set scrolloff=1000
set fillchars=vert:│,fold:-
set lazyredraw
set cursorline 

" Persistent undo.
if has('persistent_undo')
    set undodir=~/.vim/undo/
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Barra de estado.
set laststatus=2
set statusline=[%n]\ %t\ %1(%M%)\ %r\ %{LvGitBranch()}%=\ %Y\ %<R%5l\ C%5v\ %3p%%

" Coloreo de sintaxis.
syntax on
colorscheme jellybeans

" Formato.
" Tiene que ir después del tema, sino no anda.
set tw=79
set fo=tcqr
