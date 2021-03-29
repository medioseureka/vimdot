set nocompatible
syntax on

filetype plugin on
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-iCursor-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20
set relativenumber
set nu
set hidden
set noerrorbells
set smartcase
set autoindent
set expandtab
set noswapfile
set tabstop=4 softtabstop=4
set shiftwidth=4
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set wildmenu
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect

let loaded_matchparen = 1
let mapleader = " "

" NETRW CONFIGURATIONS
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 15

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set cursorline

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'sainnhe/sonokai'
Plug 'itchyny/lightline.vim'

Plug 'mattn/emmet-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

Plug 'godlygeek/tabular'

" polyglot file types
Plug 'jwalton512/vim-blade'
call plug#end()

if has('termguicolors')
  set termguicolors
endif
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai
let g:sonokai_style = 'atlantis'
let g:sonokai_menu_selection_background = 'green'
let g:sonokai_cursor = 'green'
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnostic_line_highlight = 1

" list all buffers and press number to go to
:noremap <C-b> :buffers<CR>:buffer<Space>

" open tree
:noremap <C-n> :Explore<CR>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" commands
" Lint Vue project
command! VueLint !eslint --fix . --ext .js,.vue .
" Make tags from project
command! MakeTags !ctags -R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor .
" Redraw a file which has no colorized
command! Rd syntax sync fromstart
" tells vim to remove CRLF and LF-only line endings
nnoremap <leader>tu :e ++ff=dos <CR>:set ff=unix<CR>

" This way, whenever you type % you jump to the matching object,
" and you visually select all the text in between.
noremap % v%

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
      \ 'rebase': {
      \   'prompt': 'Rebase> ',
      \   'execute': 'echo system("{git} rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-t',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}
" FZF
nnoremap <leader>p :Files<CR>
nnoremap <leader>pg :GFiles<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>ag :Ag<CR>

" **************
" *                                    *
" **** COC SERVER ******
" CocInstall coc-phpls coc-pairs coc-tsserver coc-vetur coc-snippets coc-html

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" use coc-snippets and tab completion tab expand snippet and navigate snippet
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
