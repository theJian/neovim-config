"─── General ───────────────────────────────────────────────────────────────────
" compatible options
set cpoptions+=n
set cpoptions+=y
set cpoptions-=;

" indent
set smartindent

" tab
set softtabstop=4
set tabstop=4
set shiftwidth=4

" mouse
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
set foldopen-=block

" file format
set fileformat=unix

" line break at `breakat` characters
set linebreak

" no backup file, no swap file
set nobackup
set noswapfile

" allow cursor to move just past the end of the line
set virtualedit=onemore

" always use system clipboard
set clipboard+=unnamedplus

" shows the effects of a command incrementally
set inccommand=nosplit

" automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =


"─── User Interface ────────────────────────────────────────────────────────────
" colorscheme
set background=dark
colorscheme fethoi

" true color
set termguicolors

" show invisible chars
set list
set listchars=tab:›\ ,trail:•,extends:§,nbsp:•
highlight NonText    ctermfg=12
highlight SpecialKey ctermfg=12

" show match
set showmatch
set matchtime=2

" highlight comment
highlight Comment cterm=italic

" matches highlighting colors
hi MatchParen cterm=underline ctermbg=none ctermfg=LightGreen gui=underline guibg=NONE guifg=LightGreen

" folded highlighting colors
hi Folded ctermbg=none ctermfg=DarkCyan guibg=NONE guifg=DarkCyan

" font
set guifont=Inconsolata:h16

" simplify gui
set guioptions=av

" statusline
set statusline=%f " file path
set statusline+=%1*%m%*%r%h%w "file info
set statusline+=%= "switch to the right side
set statusline+=(%{&ff}/%Y) " file type
set statusline+=\  " separator
set statusline+=(line\ %l\/%L,\ col\ %c) " cusor position
set statusline+=\  " seperator
set statusline+=%<%P " percentage
" highlight modified flag
highlight User1 ctermfg=red guifg=red

" highlight cursor position
set cursorcolumn
set cursorline

" minimal number of screen lines to keep
set scrolloff=2

" only have cursorline in current window
autocmd WinLeave * set nocursorline
autocmd WinLeave * set nocursorcolumn
autocmd WinEnter * set cursorline
autocmd WinEnter * set cursorcolumn

" show line number
set number
set relativenumber

" add a colored line at 81 column
set colorcolumn=81

" solid window split border
set fillchars+=vert:\ 

" dotted folded line
set fillchars+=fold:┄

" wrapped line mark
set showbreak=↪\ \ \ 

"─── Key Mapping ───────────────────────────────────────────────────────────────
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
nnoremap <C-Enter> o<Esc>
nnoremap <S-Enter> O<Esc>

" split window
nnoremap <leader>h :<C-u>split<CR>
nnoremap <leader>v :<C-u>vsplit<CR>

" copy/paste/cut
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>x "+x
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" close buffer
nnoremap <leader>q :<C-u>bd<CR>

" clean search highlight
nnoremap <silent> <BS> :<C-u>noh<CR>

" switching panes
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" shifting
vnoremap < <gv
vnoremap > >gv

" move visual block
vnoremap J :<C-u>m '>+1<CR>gv=gv
vnoremap K :<C-u>m '<-2<CR>gv=gv

" select last changed text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" escape to normal mode in terminal
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>

" command line editing
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" execute the last macro over the selection
xnoremap @ :'<,'>:normal @@<CR>

"─── User Scripts ──────────────────────────────────────────────────────────────
" automatic create directory when it doesn't exist
augroup Mkdir
	autocmd!
	autocmd BufNewFile *
				\ if !isdirectory(expand("<afile>:p:h")) |
				\ call mkdir(expand("<afile>:p:h"), "p") |
				\ endif
augroup END

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

augroup HelpInTabs
	autocmd!
	autocmd BufEnter *.txt call HelpInNewTab()
augroup END

" only apply to help files
function! HelpInNewTab()
	if &buftype == 'help'
		" convert help window to tab
		execute "normal \<C-W>T"
	endif
endfunction

function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

nnoremap <leader>e :call FzyCommand("rg --files", ":e")<cr>

"─── Files Specified ───────────────────────────────────────────────────────────
" Elm
augroup file_elm
	autocmd!
	autocmd BufNewFile,BufRead *.elm set tabstop=4
	autocmd BufNewFile,BufRead *.elm set softtabstop=4
	autocmd BufNewFile,BufRead *.elm set shiftwidth=4
augroup END

"─── Plugin Settings ───────────────────────────────────────────────────────────
" run deoplete at start up
let g:deoplete#enable_at_startup = 1

" deoplete key mapping
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
function! s:check_back_space() abort "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
