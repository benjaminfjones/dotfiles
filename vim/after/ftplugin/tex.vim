setlocal spell
set noautoindent
set nosmartindent
set indentexpr=''

" Insert a separating line
nmap <buffer> --l ^72i%<Esc>^llR<Space>

" Insert a FAT separating line
nmap <buffer> --L ^72i%<Esc>yypO%%<Space>
