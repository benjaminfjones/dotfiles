" ghc-mod customizations

" async check and lint
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

" lint options
let g:ghcmod_hlint_options = ['--ignore=Redundant $', '--ignore=Use camelCase', '--cpp-define=HLINT']

" sub-expression highlighting
hi ghcmodType ctermbg=yellow
let g:ghcmod_type_highlight = 'ghcmodType'

" quickfix status line
let &l:statusline = '%{empty(getqflist()) ? "[No Errors]" : "[Errors Found]"}' . (empty(&l:statusline) ? &statusline : &l:statusline)

" hotkeys
nnoremap <Leader>t :GhcModType<CR>
nnoremap <Leader>y :GhcModTypeClear<CR>
nnoremap <Leader>c :GhcModCheck<CR>
nnoremap <Leader>l :GhcModLint<CR>

