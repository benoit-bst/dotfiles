"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" sources finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'google/vim-searchindex'
" highlight syntax
Plug 'sheerun/vim-polyglot'
" parentheses
Plug 'kien/rainbow_parentheses.vim'
" folder bar
Plug 'scrooloose/nerdtree'
" comment
Plug 'scrooloose/nerdcommenter'
" git diff
Plug 'mhinz/vim-signify'
" tmux
Plug 'christoomey/vim-tmux-navigator'
" zoom
Plug 'junegunn/goyo.vim'
" C-Sharp
Plug 'OmniSharp/omnisharp-vim'
" syntax checker for c sharp
Plug 'vim-syntastic/syntastic'
" debug
Plug 'puremourning/vimspector'

if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
endif

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <F1> :NERDTreeToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=500
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => status bar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_powerline_fonts = 1
let g:airline_theme='dark'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git signify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight DiffAdd     cterm=bold ctermbg=106 ctermfg=15
highlight DiffDelete  cterm=bold ctermbg=160 ctermfg=15
highlight DiffChange  cterm=bold ctermbg=172 ctermfg=15

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>j :FZF<cr>
map <leader>h :History<cr>
map <leader>g :Rg<Space>
map <leader>l :BLines<cr>
map <leader>L :Lines<cr>
map <leader>t :BTags<cr>
map <leader>T :Tags<cr>
map <leader>s :Snippets<cr>
map <leader>f :Buffers<cr>
map <leader>bb :Buffers<cr>
let g:fzf_buffers_jump = 1
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

 "use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" switch header/source
map <leader>A :CocCommand clangd.switchSourceHeader<cr>

let g:coc_global_extensions=['coc-html', 'coc-css', 'coc-java', 'coc-clangd', 'coc-cmake', 'coc-json', 'coc-pyright', 'coc-sh', 'coc-yaml', 'coc-tsserver', 'coc-jedi', 'coc-markdownlint', 'coc-sql', 'coc-highlight', 'coc-solargraph']

" highlight current word bellow cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow Parentheses
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => C Sharp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:OmniSharp_selector_ui = 'fzf'    " Use fzf
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_highlighting = 0
let g:OmniSharp_diagnostic_showid = 1

"inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
"\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'

" only for c-sharp...
let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_java_checkers = ['']
let g:syntastic_c_checkers = ['']
let g:syntastic_go_checkers = ['']
let g:syntastic_ruby_checkers = ['']

