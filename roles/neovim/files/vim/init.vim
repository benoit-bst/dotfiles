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
set nocompatible

" Reload files
set autoread
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
set updatetime=800

" backup
set backup
"set nowb
set noswapfile
try
    set backupdir=~/.config/nvim/temps_dirs/backup
    set dir=~/.config/nvim/temps_dirs/backup
    set undodir=~/.config/nvim/temps_dirs/undodir
    set undofile
catch
endtry

set mouse=a

" Syntax
syntax on
set background=dark
colorscheme monokai

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
"map <F2> <Esc>:enew<cr>
"map <F3> <Esc>:bd<cr>
"map <F4> <Esc>:bprevious<cr>
"map <F5> <Esc>:bnext<cr>
noremap <F2> :set invnumber<cr>
noremap <F3> :set list!<cr>:set list?<cr>
nmap <F5> :CocCommand java.debug.vimspector.start<CR>
set listchars=eol:¤,trail:-

"when you close file
autocmd BufWritePre *.cpp,*.cc,*.h,*.hpp,*.c,*.py,*.go,*.rs,*.yml %s/\s\+$//e

" Json auto indent
command! JsonAutoIndent :%!python -m json.tool

" ctags
set tags=./tags,tags;
fun! UpdateTags()
    if filereadable("tags")
        call system("ctags -a -R .")
        echo "ctags is updated"
    else
        echo "ctags file doesn't exist"
    endif
endfun
command! UpdateTags :call UpdateTags()
command! CC :call UpdateTags()

" file format
au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.go set ft=go
au BufNewFile,BufRead *.rs set ft=rust
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
nnoremap <leader>r :%s/\<<c-r><c-w>\>//g<left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Rg " . l:pattern . "" )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '//g<left><left>')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" plugins config
source ~/.config/nvim/plugins_config/plugins_config.vim

" adapt tmux with vim
map <ESC>[5D <C-Left>
map <ESC>[5C <C-Right>
map! <ESC>[5D <C-Left>
map! <ESC>[5C <C-Right>
