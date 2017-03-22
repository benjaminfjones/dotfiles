au BufRead,BufNewFile *.lean set ft=lean

" Neomake configuration
autocmd! BufWritePost * Neomake
let g:neomake_lean_lean_maker = {
    \ 'args': ['--quiet'],
    \ 'errorformat': '%f:%l:%c: error: %m, %f:%l:%c: warning: %m',
    \ }
let g:neomake_lean_enabled_makers = ['lean']
