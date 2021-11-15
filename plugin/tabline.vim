" Author: romes

set showtabline=1 | " Enable tabline when tabs > 1

hi TabLineSel   ctermfg=black   ctermbg=yellow cterm=none
hi TabLine      ctermfg=white   ctermbg=none   cterm=none
hi TabLineFill  ctermfg=white   ctermbg=none   cterm=none

let g:ja_number_map = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十']

function MakeTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return fnamemodify(bufname(buflist[winnr - 1]), ':t')
endfunction

function! MakeTabLine()
    let s = ''

    for i in range(tabpagenr('$'))

        " buffers in tab
        let buflist = tabpagebuflist(i + 1)


        " select the highlighting
        if i + 1 == tabpagenr()
            let s ..= '%#TabLineSel#'
        else
            let s ..= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s ..= '%' .. (i + 1) .. 'T'

        " display the tab number in japanese
        let s ..= ' %{g:ja_number_map[' .. (i) .. ']} '

        " the label is made by MakeTabLabel()
        let s ..= '%(%{MakeTabLabel(' .. (i + 1) .. ')} %)'

        " set modified if any buffer in tab has been modified
        let s:m = 0
        for b in buflist
            if getbufvar(b, '&modified')
                let s:m += 1
            endif
        endfor
        
        if s:m > 0
            let s ..= '+ '
        endif

    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLineSel#%999X[X]'
    endif

    return s
endfunction

set tabline=%!MakeTabLine()

