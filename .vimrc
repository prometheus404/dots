"""""""""""""
" VIM BASIC "
"""""""""""""
syntax on			"attiva colorazione sintassi
set autoindent		"indentazione automatica
set tabstop=4		"tab = 4 spazi
set shiftwidth=4	"come sopra
set nu				"righe numerate
set nowrap			"no a capo automatico
set noswapfile		"non servono file di swap
set nobackup		"ne di backup con undotree
set nowritebackup	"per coc
set cmdheight=2
set undodir=~/.vim/undodir	"setup directory undotree (va creata a mano)
set undofile		"sempre per undotree
set incsearch		"ricerca incrementale 
set backspace=indent,eol,start	"per evitare comportamenti strani di backspace
set hidden			"non mi ricordo ma serviva a qualcosa
set mouse=a			"supporto mouse (forse in un emulatore di terminale non serve)

"impostazioni riga laterale
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


""""""""""
" PLUGIN "
""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'										"tema
Plug 'https://github.com/kien/ctrlp.vim.git'				"file manager
Plug 'neoclide/coc.nvim', {'branch': 'release'}				"suggerimenti, go to definition ecc
"Plug 'https://github.com/ycm-core/YouCompleteMe.git'		"coc e' meglio
Plug 'mbbill/undotree'										"mantiene lo storico delle modifiche
Plug 'vim-airline/vim-airline'								"per gestione tab e per info grafiche
Plug 'vim-airline/vim-airline-themes'						"temi per airline
Plug 'sillybun/vim-repl'									"repl per qualsiasi linguaggio comodo per debuggare al volo
call plug#end()

"setup colorscheme
colorscheme gruvbox
set background=dark

"uso spazio come leader perche' piu' comodo
let mapleader = " "

"setup comandi repl
let g:repl_position = 0
let g:repl_stayatrepl_when_open = 0
let g:repl_cursor_down = 1
let g:sendtorepl_invoke_key = "<leader>w"

let g:repl_cursor_down = 1
let g:repl_height = 10
"specifico che programma usare nel repl e come chiuderlo
let g:repl_program = {
					\	'python': ['python3'],
					\	'ocaml': ['utop'],
					\	'erlang': ['erl'],
					\	'default': ['fish']
					\}
let g:repl_exit_command = {
						\ 'python3': 'quit()',
						\ 'utop': 'exit 0',
						\ 'erl': 'q().',
						\ 'default': 'exit'
						\ } 


"ctrlp
let g:ctrlp_user_command = ['git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:netrw_browse_split=2
let g:netrw_browse_banner=0
let g:netrw_winsize=25
let g:ctrlp_use_caching=0
"airline
"let g:airline#extensions#tabline#enabled = 1		"gestione tab in alto
let g:airline_theme='base16'						"tema che uso
"let g:airline_theme='bubblegum'					"altri temi
"let g:airline_theme='angr'

"per avere la grafichetta figa(ma forse devi installare un font aposta)
let g:airline_left_sep = '»'
let g:airline_left_sep = ''
let g:airline_right_sep = '«'
let g:airline_right_sep = ''


""""""""""""
" SHORTCUT "
""""""""""""
"split rapido
nnoremap <leader>h :split<CR>
nnoremap <leader>v :vsplit<CR>
"movimento rapido tra le finestre e resize
nnoremap <leader>n :wincmd h<CR>
nnoremap <leader>e :wincmd j<CR>
nnoremap <leader>i :wincmd k<CR>
nnoremap <leader>o :wincmd l<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
"apri plugin
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>r :REPLToggle <CR>
"ricarica il file
nnoremap RR :e!<CR>
"movimento rapido tra tab e gestione tab
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>q :q<CR>
nnoremap <leader>t :tabnew<CR>
"""""""
" COC "
"""""""
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
"questi devo cambiarli per adattarli a coc
"nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
"nnoremap <silent> <leader>gd :YcmCompleter FixIt<CR>
