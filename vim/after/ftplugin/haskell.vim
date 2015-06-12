
" quickfix status line
let &l:statusline = '%{empty(getqflist()) ? "[No Errors]" : "[Errors Found]"}' . (empty(&l:statusline) ? &statusline : &l:statusline)

" ghc-mod customizations
if executable('ghc-mod')

    " async check and lint
    autocmd BufWritePost *.hs GhcModCheckAndLintAsync

    " lint options
    let g:ghcmod_hlint_options = ['--ignore=Redundant $', '--ignore=Use camelCase', '--cpp-define=HLINT']

    " sub-expression highlighting
    hi ghcmodType ctermbg=yellow
    let g:ghcmod_type_highlight = 'ghcmodType'

    " hotkeys
    nnoremap <Leader>t :GhcModType<CR>
    nnoremap <Leader>y :GhcModTypeClear<CR>
    nnoremap <Leader>ck :GhcModCheck<CR>
    nnoremap <Leader>li :GhcModLint<CR>

endif
