" init.vim (neovim)
"
" Author: Benjamin Jones <bfj@amazon.com>
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prelude

" Set the leader as ';' instead of '\'
let mapleader      = ";"
let maplocalleader = ";"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins (vim-plug)

call plug#begin(stdpath('data') . '/plugin-home')

" The Pope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Vim Lion - quick alignment
"
" e.g,
"     glip=
"     3gLi(,
"     glip/-->
"     <visual>gl=
"
Plug 'tommcdo/vim-lion'

" Tabular (better for code formatting)
Plug 'godlygeek/tabular'
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>

Plug 'itchyny/lightline.vim'
set laststatus=2  " enable status line and message line
set noshowmode    " turn off redundant mode display
let g:lightline = {
      \  'colorscheme': 'solarized',
      \  'active': {
      \    'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'relativepath' ] ],
      \    'right': [ [ 'percent', 'lineinfo', 'formatoptions' ], [ 'filetype' ] ]
      \  },
      \  'component': {
      \    'formatoptions': '[%{&fo}]'
      \  }
      \}


" fzf and fzf.vim:  https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" *** Mappings ***
" git tracked files
nmap <space> :GFiles<CR>
nmap <Leader>f :GFiles<CR>
" all files
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
" current buffer lines
nmap <Leader>l :BLines<CR>
" all open buffer lines
nmap <Leader>L :Lines<CR>
" Brazil ws version of :Files
command! -bang WSFiles call fzf#vim#files('../', <bang>0)


" Color scheme choices
" Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'

" QFEnter - open quickfix/loclist items in splits, tabs, etc..
Plug 'yssl/QFEnter'
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>']
let g:qfenter_keymap.vopen = ['<Leader>v']
let g:qfenter_keymap.hopen = ['<Leader>h']
let g:qfenter_keymap.topen = ['<Leader>t']

" ALE
Plug 'w0rp/ale'
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'python': ['flake8', 'mypy'],
\   'rust': ['rustc', 'rls'],
\   'java': ['javac', 'checkstyle']
\}
let g:ale_sign_column_always = 1
" go to next or prev error
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" vimwiki
Plug 'vimwiki/vimwiki'
let automatic_nested_syntaxes = 1
let g:vimwiki_url_maxsave=0
nmap <Leader>tt <Plug>VimwikiToggleListItem

" Better JSON highlighting / folding / linting
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Rust.vim
" Format rust file :RustFmt
" Run test under cursor: :RustTest
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 0

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Post-plugin options
"

" Enable filetype detection
filetype plugin indent on

" ignore case when all letters are lower case
set ignorecase smartcase

" Allow backspacing over everything
set backspace=indent,eol,start

" Incremental searching
set incsearch

" Cursor context
set scrolloff=3

" Always show cursor position
set ruler

" Fold by manually defined folds
set nofoldenable

" Syntax
syntax enable
set hlsearch

" Spell checking
if has("spell")
    setlocal spell spelllang=en_us
    set nospell
endif

" set text wrap width
set textwidth=78

" Highlight trailing space, and tab characters
set list
set listchars=tab:▸·,trail:·

" Completion options
set wildmode=longest:full,list:full
set wildmenu
set wildignore=*.o,*.hi,*.swp,*.bc

" Colors!
" set Vim-specific sequences for RGB colors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" set termguicolors
set background=dark
colorscheme solarized8

" reset highlighting
highlight Normal cterm=NONE ctermbg=NONE
highlight SignColumn ctermbg=Black

" Grey cursor line/col highlights
highlight CursorLine   term=bold cterm=bold guibg=Grey40
highlight CursorColumn term=bold cterm=bold guibg=Grey40

" Disable the bell
set noerrorbells
set visualbell
set t_vb=

" Tabs and Indenting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set breakindent
set autoindent
set smartindent
set expandtab

" Row/Column accents
set nocursorcolumn
set nocursorline
set nonumber
set norelativenumber

" Join spaces: when joining lines or reflowing paragraphs, only use one space
" to separate sentences, not two
set nojoinspaces


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TABS

" Tab/buffer navigation
function! Next()
    if tabpagenr('$') > 1
        tabnext
    else
        bnext
    endif
endfunction

function! Prev()
    if tabpagenr('$') > 1
        tabprevious
    else
        bprevious
    endif
endfunction

nnoremap <silent> <C-n> :call Next()<Cr>
nnoremap <silent> <C-p> :call Prev()<Cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL mode mappings

" Define double <leader> to kill the search highlighting.
nnoremap <Leader><Leader> :noh<Enter>
" set cursorline
nnoremap <Leader>c :set cursorcolumn!<CR>
nnoremap <Leader>C :set cursorline!<CR>
" uppercase the current word, put cursor after last char
nnoremap <c-u> viwUea
" edit $VIMRC in a split
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
" source $VIMRC
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Disable the help key
nnoremap <F1> <Esc>
" Set F2 as the binding to toggle the paste mode
set pastetoggle=<F2>
" Use F3 to toggle spelling
nnoremap <F3> :set spell!<CR>
" remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INSERT mode mappings

" Disable the help key
inoremap <F1> <Esc>
" jk trick!
inoremap jk <Esc>
" Crtl-d to delete current line
inoremap <c-d> <ESC>ddi
" uppercase current word, put cursor back insert mode after last char
inoremap <c-u> <ESC>viwUea

" Disable the arrow keys when in edit mode
inoremap <Up>    <NOP>
inoremap <Right> <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations

iabbrev @@ bfj@amazon.com
iabbrev adn and
iabbrev waht what
iabbrev tehn then
