let g:shizukesa_enabled=0
let s:shizukesa_winwidth=100

function! Shizukesa()

    if g:shizukesa_enabled

        wincmd h
        close
        wincmd l
        close
        wincmd k
        close
        wincmd j
        close

        set nu rnu
        set laststatus=2

        let g:shizukesa_enabled = 0
    else

        set nonu nornu   | " Remove numbers and relative numbers
        set laststatus=0 | " Disable statusline

        silent only

        " Vertical windows {{{
        vsplit
        vsplit

        enew
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
        "}}}

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
