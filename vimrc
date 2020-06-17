set nocompatible
syntax on
filetype plugin indent on
set nowrap
set encoding=utf8
let mapleader=","

" OSX backspace
set backspace=indent,eol,start

" Show line number
set number relativenumber
set ruler
set cursorline

" Save with F2 in insert mode
inoremap <F2> <C-\><C-o>:w<CR>

" Tabs
set expandtab " spaces instead tab
set tabstop=2
set shiftwidth=2
set smarttab

" Indentation
set autoindent
set smartindent

call plug#begin()
" Utilities
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'moll/vim-bbye' " delete buffers
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular' " Tab the selection to avoid mismatch equals signs
Plug 'gilsondev/searchtasks.vim' " Search TODO FIXME XXX Example: :SearchTasks .
Plug 'tpope/vim-dispatch' " To run async tests
Plug 'neomake/neomake'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'

" Generic Programming Support
Plug 'Townk/vim-autoclose'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" GIT
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Color Schemes
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

call plug#end()


" Always display the status line
set laststatus=2

" Theme and Styling
set t_Co=256
"set background=dark    " Setting dark mode
set background=light   " Setting light mode

if (has("termguicolors"))
  set termguicolors
endif

let base16colorspace=256  " Access colors present in 256 colorspace
let g:gruvbox_contrast_light='hard'
let g:gruvbox_number_column='fg4'
colorscheme gruvbox

" ******* Moving Between Splits *****
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" ******* Moving Between Splits *****

" List all buffers
:nnoremap <F5> :buffers<CR>:buffer<Space>

" JSON
autocmd FileType json syntax match Comment +\/\/.\+$+


" **************************************
" *                                    *
" *       PLUGINS CONFIGURATION        *
" *                                    *
" **************************************

" Coc
" !!!!!!!!!!!!!!!!!!!! COC needs install the servers !!!!!!!!!!!!!!!
" SQL https://github.com/joe-re/sql-language-server
" PHP https://github.com/marlonfan/coc-phpls
" PYTHON https://github.com/neoclide/coc-python
" JAVASCRIPT TYPESCRIPT https://github.com/neoclide/coc-tsserver
" ESLINT https://github.com/neoclide/coc-eslint
" VUE https://github.com/neoclide/coc-vetur
" ANGULAR https://github.com/iamcco/coc-angular
" CocInstall coc-tsserver coc-json coc-html coc-css coc-python coc-phpls coc-angular coc-eslint coc-vetur

set statusline^=%{coc#status()}
" !!!!!!!!!!!!!!!!!!!! COC needs install the servers !!!!!!!!!!!!!!!

" Vim-Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='hybrid'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

" ****************fzf********************************
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
" ****************fzf********************************

" BBY delete buffers
:nnoremap <Leader>q :Bdelete<CR>

" Neomake
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)

" vim-signify
" default updatetime 4000ms is not good for async update
set updatetime=100

"**************NerdTree*****************
map <C-n> :NERDTreeToggle<CR>
" Close vim when NERDTree is the only one left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"**************NerdTree*****************

" **************************************
" *                                    *
" *            FUNCTIONS               *
" *                                    *
" **************************************

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
