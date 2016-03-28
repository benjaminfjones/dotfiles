setlocal autoindent
setlocal nocindent
setlocal expandtab

" Set the tab size
setlocal tabstop=4
setlocal shiftwidth=2

setlocal include="^\s*import\s\+\(qualified\s\+\)\?\zs[^ \t]\+\ze"
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.hs'

highlight hsComment term=NONE ctermfg=cyan

nmap <buffer> K <Nop>

" Insert a separating line
nmap <buffer> --l ^72i-<Esc>^llR<Space>

" Insert a FAT separating line
nmap <buffer> --L ^72i-<Esc>yypO<Space>

" Insert a Haddock comment
nmap <buffer> --\| O--<Space>\|<Space>

" Insert a language pragma
nmap <buffer> <localleader>l O{-# LANGUAGE  #-}<Esc>hhhi

" Insert an import declaration
nmap <buffer> <localleader>i Oimport<Space>


if haskell#StackYamlFileExists()  " Configure :make for stack build
    compiler stack-build
elseif haskell#CabalFileExists()  " Configure :make for cabal build
    compiler cabal-build
endif
