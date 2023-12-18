" ======== Options ============= "

setlocal textwidth=80

" ======== Insert Mode ========= "
"   |
"       automatically align tables of form | .* | .* | ...
"

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" ======== Other =============== "

" cucumbertables.vim :: tpope's function to automatically align bar tables using Tabular
function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction
