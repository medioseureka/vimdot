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

" list all buffers and press number to go to
:noremap <C-b> :buffers<CR>:buffer<Space>

" open tree
:noremap <C-n> :Explore<CR>

" commands
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
