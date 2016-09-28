setlocal autoindent
setlocal nocindent
setlocal expandtab

highlight hsComment term=NONE ctermfg=cyan

nnoremap <buffer> K <Nop>
vnoremap <buffer> K <Nop>

" Insert a separating line
nnoremap <buffer> <LocalLeader>l ^80i-<Esc>^llR<Space>

" Insert a Haddock comment
nnoremap <buffer> --\| O--<Space>\|<Space>

" Pragmas
nnoremap <buffer> <localleader>#l O{-# LANGUAGE  #-}<Esc>hhhi
nnoremap <buffer> <localleader>#i O{-# INLINE  #-}<Esc>hhhi
nnoremap <buffer> <localleader>#u i{-# UNPACK #-} <Esc>F{

" Insert an import declaration
nnoremap <buffer> <localleader>i Oimport 

" Set the tab size
setlocal tabstop=4
setlocal shiftwidth=2

" Spellcheck comments
setlocal spell

" Configure :make
if haskell#CabalProjectFileExists()
    compiler cabal-new-build
elseif haskell#StackYamlFileExists()
    compiler stack-build
elseif haskell#CabalFileExists()
    compiler cabal-build
endif

" Setup include and includeexpr
call haskell#FollowImports()

nmap <buffer> gf <Plug>(haskell-gf)

" parameters for the syntax highlighter
if (exists("hs_highlight_boolean"))
    unlet hs_highlight_boolean
endif
if (exists("hs_highlight_delimiters"))
    unlet hs_highlight_delimiters
endif
if (!exists("hs_allow_hash_operator"))
    let hs_allow_hash_operator=1
endif
if (exists("hs_highlight_cpp"))
    unlet hs_highlight_cpp
endif
