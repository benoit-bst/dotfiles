" Common
set history=500
set encoding=utf8
set autoindent
set smartindent
set number
set cursorline
set colorcolumn=113
set wildmenu
set ruler
set ignorecase
set smartcase
set incsearch
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set noswapfile

set mouse=a

" Syntax
syntax on
set background=dark

" leader
let mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>
nmap <leader>x :x!<cr>
nmap <leader>e :e<cr>

" split windows
nmap <leader>- :split<cr>
nmap <leader>/ :vsplit<cr>

" tabs
nmap <leader><Left> :bprevious<cr>
nmap <leader><Right> :bnext<cr>
map <leader>p :bprevious<cr>
map <leader>n :bnext<cr>
map <leader>o :enew<cr>

" buffers
map <leader>bp :bprevious<cr>
map <leader>bn :bnext<cr>
map <leader>bo :enew<cr>
map <leader>bd :bd<cr>
map <leader>bc :bd<cr>
map <leader>ba :bufdo bd<cr>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" go to definition
nnoremap <leader>] <C-]>

" Toggle paste mode on and off
map <leader>P :setlocal paste!<cr>

" shortcut
map <F2> <Esc>:enew<cr>
map <F3> <Esc>:bd<cr>
map <F4> <Esc>:bprevious<cr>
map <F5> <Esc>:bnext<cr>
noremap <F6> :set invnumber<cr>
noremap <F7> :set list!<cr>:set list?<cr>
set listchars=eol:¤,trail:-

"when you close file
autocmd BufWritePre *.cpp,*.cc,*.h,*.hpp,*.c,*.py,*.go,*.rs,*.yml %s/\s\+$//e

