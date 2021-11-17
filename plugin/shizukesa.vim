let g:shizukesa_enabled=0
let g:shizukesa_min_winwidth=100

function! Shizukesa()

    if g:shizukesa_enabled

        silent only

        set nu rnu
        set laststatus=2

        " Reenable window commands
        unmap <silent> <C-w>

        let g:shizukesa_enabled = 0
    else

        set nonu nornu   | " Remove numbers and relative numbers
        set laststatus=0 | " Disable statusline

        silent only

        let totalww = winwidth('%')

        " Vertical windows {{{
        vsplit
        vsplit

        enew
        setlocal winwidth=5
        2wincmd l
        enew
        setlocal winwidth=5
        wincmd h

        let s:shizukesa_winwidth=max([g:shizukesa_min_winwidth, totalww*5/7]) " Use 5/7 of screen if satisfies min_winwidth

        let ww = winwidth('%')
        let needs_width_per_side = (s:shizukesa_winwidth - ww) / 2

        if needs_width_per_side > 0
            wincmd h
            execute "vertical resize " .. -needs_width_per_side
            2wincmd l
            execute "vertical resize " .. -needs_width_per_side
            wincmd h
        endif

        " Sometimes the two sideway paddings won't have the same width,
        " And the leftmost split will be 1 column larger. In this case,
        " Resize the leftmost split by -1
        wincmd l
        let rightw = winwidth('%')
        2wincmd h
        let leftw = winwidth('%')
        wincmd l
        if leftw == rightw + 1
            wincmd h
            vertical resize -1
            wincmd l
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

        " Disable window commands
        noremap <silent> <C-w> :<CR>

        highlight! VertSplit cterm=none ctermbg=none ctermfg=black

        let g:shizukesa_enabled = 1
    endif

endfunction

" vim: fdm=marker
