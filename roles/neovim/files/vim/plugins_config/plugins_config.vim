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
" parentheses
Plug 'junegunn/rainbow_parentheses.vim'
" illuminate same works
Plug 'RRethy/vim-illuminate'
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
" terraform
Plug 'hashivim/vim-terraform'
" c++ hightlight
Plug 'jackguo380/vim-lsp-cxx-highlight'

if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
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
" => vim-lsp-cxx-highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add extra colors (syntax files)
let g:cpp_member_variable_highlight = 1
let g:cpp_no_function_highlight = 1
let g:cpp_simple_highlight = 1
let g:cpp_named_requirements_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:python_highlight_all=1

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow Parentheses
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.cpp,*.cc,*.h,*.hpp,*.c,*.py,*.go,*.rs RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
