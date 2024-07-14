set shiftwidth=4
set tabstop=4
set expandtab
set ignorecase
set hlsearch
set number
set scrolloff=10
set nowrap
syntax on
set relativenumber
set showmatch
set showmode
nnoremap <esc><esc> :silent! nohls<cr>
call plug#begin()
    Plug 'noahfrederick/vim-hemisu'
    Plug 'rose-pine/vim'
call plug#end()

colorscheme hemisu
set background=dark
hi Normal guibg=NONE ctermbg=NONE






