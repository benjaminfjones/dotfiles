au! BufNewFile,BufRead *.task,*.tasks,todo.txt set filetype=task
inoremap <silent> <buffer> <Leader>t <ESC>:call Toggle_task_status()<CR>i
noremap <silent> <buffer> <Leader>t :call Toggle_task_status()<CR>
