syntax on	" syntax highlighting
set hlsearch	" highlight all search results
" set ignorecase	" do case insensitive search
set incsearch	" show incremental search results as you type
set number	" display line number
set relativenumber
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline	" current line highlight
set cursorcolumn
set noro
set updatetime=100
set background=dark
set termguicolors
inoremap kj <Esc>
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 expandtab

call plug#begin()

Plug 'wuelnerdotexe/vim-enfocado'
Plug 'haishanh/night-owl.vim'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }

call plug#end()

colorscheme spaceduck
let g:enfocado_style = 'neon' " Available: `nature` or `neon`
