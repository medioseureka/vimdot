set nocompatible
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

set guicursor=
set nohlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set relativenumber
set cursorline
set nowrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set showmatch

" OSX backspace
set backspace=indent,eol,start

" Give more space for displaying messages.
set cmdheight=2
set laststatus=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

let loaded_matchparen = 1
let mapleader = " "

" **************************************
" *                                    *
" ******* SOURCE EXTERNAL FILES ********
" *                                    *
" **************************************
source ~/.vim/fragments/statusline.vim
source ~/.vim/fragments/netrw.vim

" **************************************
" *                                    *
" ******* SEARCH WITH JUST VIM  ********
" *                                    *
" **************************************
" WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" NOTE:
" - :b lets you autocomplete any open buffer
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" Ignoring node_modules
set wildignore+=**/node_modules/**
set wildignore+=**/vendor/**
set wildignore+=**/.git/**
set wildignore+=**/test/**
" If you have multiple files with the same name, then you are in trouble.
" Find will not list them out (like cscope/ctags) before it opens the file.
" You may end up making edits in the wrong file. However, enabling wildmenu 
" solves this by displaying the possible matches and allows you to choose
" which file you want to edit. 
set wildmenu

" **************************************
" *                                    *
" ********** SEARCH BY TAGS ************
" *                                    *
" **************************************
" Create a `tags` file (may need to install ctags first)
" NOW WE CAN:
" - Use CTR + ] go to jump to definition
" - Use CTR + t to jumb back up the tags stack
" - Use g + CTR + ] for list ambiuos tags
command! MakeTags !ctags -R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor .

" **************************************
" *                                    *
" *********** Color Schemes ************
" *                                    *
" **************************************
if has('termguicolors')
  set termguicolors
endif

set background=dark
let base16colorspace=256  " Access colors present in 256 colorspace
let g:gruvbox_contrast_light='hard'
let g:gruvbox_number_column='fg4'

colorscheme gruvbox

" **************************************
" *                                    *
" ************** MAPS ******************
" *                                    *
" **************************************
nnoremap <leader>gda :colorscheme gruvbox<bar>:set background=dark<CR>
nnoremap <leader>gl :colorscheme gruvbox<bar>:set background=light<CR>

nnoremap <C-H> :wincmd h<CR>
nnoremap <C-J> :wincmd j<CR>
nnoremap <C-K> :wincmd k<CR>
nnoremap <C-L> :wincmd l<CR>

" Save with F2 in insert mode
inoremap <silent> <F2> <C-\><C-o>:w<CR><Esc>

" surf faster between lines by five lines
nnoremap <Leader>j 5j
nnoremap <Leader>k 5k

nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

"Go to beginning of the line in insert mode
inoremap <C-a> <C-o>^ 
"Go to end of the line in insert mode
inoremap <C-f> <C-o>$

" list all buffers and press number to go to
:noremap <C-b> :buffers<CR>:buffer<Space>

" find a file in tags
:noremap <C-p> :find<Space>

" DelimitMate
let g:delimitMate_expand_cr = 2
" **************************************
" *                                    *
" *            FUNCTIONS               *
" *                                    *
" **************************************
" JSON
autocmd FileType json syntax match Comment +\/\/.\+$+

" This way, whenever you type % you jump to the matching object,
" and you visually select all the text in between.
noremap % v%

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

