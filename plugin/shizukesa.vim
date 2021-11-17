let g:shizukesa_enabled=0
let s:shizukesa_winwidth=100

function! Shizukesa()

    if g:shizukesa_enabled

        silent only

        set nu rnu
        set laststatus=2

        let g:shizukesa_enabled = 0
    else

        set nonu nornu              | " Remove numbers and relative numbers
        set laststatus=0            | " Disable statusline

        silent only

        let totalww = winwidth('%')

        " Vertical windows {{{
        vsplit
        vsplit

        enew
        if totalww % 3 == 1         | " If the total window width is uneven,
            vert res -1             | " the leftmost split will be 1 column
        endif                       | " larger than the rightmost one
        2wincmd l

        enew
        wincmd h

        let ww = winwidth('%')
        let needs_width_per_side = (s:shizukesa_winwidth - ww) / 2

        if needs_width_per_side > 0
            wincmd h
            execute "vertical resize " .. -needs_width_per_side
            2wincmd l
            execute "vertical resize " .. -needs_width_per_side
            wincmd h
        endif
        " }}}

        " Horizontal windows {{{
        split
        split
        enew
        setlocal statusline=\ | " Disable statusline
        resize 5
        2wincmd j
        enew
        setlocal statusline=\ | " Disable statusline
        resize 4
        wincmd k
        " }}}

        highlight! VertSplit cterm=none ctermbg=none ctermfg=black

        let g:shizukesa_enabled = 1
    endif

endfunction

" vim: fdm=marker
