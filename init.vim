"--- General -----------------------------------------------
set cindent
set mouse=nc

" open new splits on the right/bottom
set splitbelow
set splitright

" searching
set ignorecase
set smartcase

" explore files caseinsensitively
set wildignorecase

" fold
set foldmethod=syntax

" file format
set fileformat=unix

" line break at `breakat` characters
set linebreak

" no backup file, no swap file
set nobackup
set noswapfile

" allow cursor to move just past the end of the line
set virtualedit=onemore

" automatic create directory when it doesn't exist
augroup Mkdir
	autocmd!
	autocmd BufNewFile *
		\ if !isdirectory(expand("<afile>:p:h")) |
			\ call mkdir(expand("<afile>:p:h"), "p") |
		\ endif
augroup END

"--- User Interface ---------------------------------------
" colorscheme
set background=dark
colorscheme gotham

"--- Key Mapping ------------------------------------------
" leader
let mapleader="\<space>"

" exit insert mode without esc
inoremap jk <Esc>

" treat long lines as break lines
nnoremap j gj
nnoremap k gk

" save
nnoremap <leader>w :<C-u>w<CR>

" insert empty line
nnoremap <C-CR> o<Esc>
nnoremap <C-CR> O<Esc>
inoremap <C-CR> o<Esc>
inoremap <C-CR> O<Esc>

" split window
nnoremap <leader>h :<C-u>split<CR>
nnoremap <leader>v :<C-u>vsplit<CR>

" close buffer
nnoremap <leader>q :<C-u>bd<CR>

" clean search highlight
nnoremap <silent> <BS> :<C-u>noh<CR>

" switching panes
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" move visual block
vnoremap J :<C-u>m '>+1<CR>gv=gv
vnoremap K :<C-u>m '<-2<CR>gv=gv


