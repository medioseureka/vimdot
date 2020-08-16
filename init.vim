syntax on

set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Auto Close
Plug 'jiangmiao/auto-pairs'

" Alignment
Plug 'godlygeek/tabular'

" Indentation
Plug 'nathanaelkane/vim-indent-guides'

" Tags
Plug 'ludovicchabant/vim-gutentags'

" ********** GIT
Plug 'tpope/vim-fugitive'
" ********** GIT

" ********* syntax
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'StanAngeloff/php.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'posva/vim-vue'
Plug 'mattn/emmet-vim'
Plug 'jwalton512/vim-blade'
" ********* syntax

" ********* Micelaneous
Plug 'mbbill/undotree'
Plug 'vuciv/vim-bujo' " TODO Management
" ********* Micelaneous

Plug 'sainnhe/gruvbox-material'

call plug#end()

" Coc
" !!!!!!!!!!!!!!!!!!!! COC needs install the servers !!!!!!!!!!!!!!!
" SQL https://github.com/joe-re/sql-language-server
" PHP https://github.com/marlonfan/coc-phpls
" PYTHON https://github.com/neoclide/coc-python
" JAVASCRIPT TYPESCRIPT https://github.com/neoclide/coc-tsserver
" VUE https://github.com/neoclide/coc-vetur
" ANGULAR https://github.com/iamcco/coc-angular
" CocInstall coc-tsserver coc-python coc-phpls coc-angular coc-vetur

set background=dark

if has('termguicolors')
  set termguicolors
endif

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:gruvbox_material_background = 'soft'
colorscheme gruvbox-material

" Vue syntax pre procesors
let g:vue_pre_processors = ['pug', 'scss']

" indentation guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0

let loaded_matchparen = 1
let mapleader = " "

" let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
nmap <C-n> :Explore<CR>

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

autocmd BufWritePre * :call TrimWhitespace()

nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>

" Save with F2 in insert mode
inoremap <silent> <C-s> <C-\><C-o>:w<CR><Esc>

" emulate scape
inoremap jh <Esc>
inoremap jk <Esc>

" list all buffers and press number to go to
:noremap <C-b> :buffers<CR>:buffer<Space>
" map <leader>c :%bd\|e#<cr>
nnoremap <leader>ca :w <bar> %bd <bar> e# <bar> bd# <CR>

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart

command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <silent><expr> <C-space> coc#refresh()

vnoremap X "_d
inoremap <C-c> <esc>

" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" ******************** SOURCE FILES
source ~/.config/nvim/fragments/statusline.vim
source ~/.config/nvim/fragments/php.vim
source ~/.config/nvim/fragments/py.vim
source ~/.config/nvim/fragments/js.vim

let g:python3_host_prog = '/opt/anaconda3/bin/python3'

" ******************** FUNCTIONS
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Customs
command! LintVue !eslint --fix . --ext .js,.vue .

" disable arrow keys
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
  exec 'vnoremap' key '<Nop>'
endfor
