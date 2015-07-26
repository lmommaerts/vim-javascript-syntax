function! s:DetectJS()
	if getline(1) =~# '^#!\s*/usr/bin/\(env\s\)\=node\>'
        setfiletype javascript
    endif
endfunction
autocmd BufNewFile,BufRead * call s:DetectJS()
