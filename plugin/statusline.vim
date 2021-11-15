" Author:       romes

let g:statusline_more_colors = 1                          | " Highlight groups with more colors
let g:statusline_hl_reverse_groups = 0                    | " Highlight groups foreground instead of background

set laststatus=2                                          | " Always enable statusline
set noshowmode                                            | " Don't display -- MODE --

let mode_map = {
\     'n': 'NORMAL', 'i': 'INSERT',
\     'R': 'REPLACE', 'v': 'VISUAL',
\     'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
\     'c': 'COMMAND', 's': 'SELECT',
\     'S': 'S-LINE', "\<C-s>": 'S-BLOCK',
\     't': 'TERMINAL'
\   }

function! FileSize() abort
    let l:bytes = getfsize(expand('%p'))
    if (l:bytes >= 1024)
        let l:kbytes = l:bytes / 1025
    endif
    if (exists('kbytes') && l:kbytes >= 1000)
        let l:mbytes = l:kbytes / 1000
    endif

    if l:bytes <= 0
        return ''
    endif

    if (exists('mbytes'))
        return l:mbytes . 'MB'
    elseif (exists('kbytes'))
        return l:kbytes . 'KB'
    else
        return l:bytes . 'B'
    endif
endfunction


set statusline=%1*\ %{mode_map[mode()]}\                  | " Mode

if g:statusline_more_colors
    set statusline+=%4*
else
    set statusline+=%0*
endif
set statusline+=\ %t\                                     | " File name
set statusline+=%(%M\ %)                                  | " Modified flag

set statusline+=%2*\ %n\                                  | " Buffer number

set statusline+=%0*%(\ %r%)                               | " Read-only flag
set statusline+=%(\ %h%)                                  | " Help flag
set statusline+=%(\ %w%)                                  | " Preview flag

set statusline+=%0*%=                                     | " Switch to right-side

set statusline+=%2*%(\ %{&filetype}\ %)                   | " Filetype

if g:statusline_more_colors
    set statusline+=%5*
else
    set statusline+=%0*
endif
set statusline+=%(\ %{FileSize()}\ \|%)                   | " File size
set statusline+=%(\ %{&fenc?&fenc:&enc}\ \|%)             | " Encoding
set statusline+=\ %p%%\                                   | " Percentage

set statusline+=%3*\ %3l:%-2c\                            | " Line:Column


hi StatusLine ctermfg=white ctermbg=none cterm=none
hi StatusLineNC ctermfg=black ctermbg=white cterm=reverse

if g:statusline_hl_reverse_groups
    hi User1 ctermfg=red ctermbg=none cterm=none          | " Red foreground
    hi User2 ctermfg=yellow ctermbg=none cterm=none       | " Yellow foreground
    hi User3 ctermfg=blue ctermbg=none cterm=none         | " Blue foreground
    hi User4 ctermfg=magenta ctermbg=none cterm=none      | " Magenta foreground
    hi User5 ctermfg=cyan ctermbg=none cterm=none         | " Cyan foreground
else
    hi User1 ctermfg=black ctermbg=red cterm=none         | " Red background
    hi User2 ctermfg=black ctermbg=yellow cterm=none      | " Yellow background
    hi User3 ctermfg=black ctermbg=blue cterm=none        | " Blue background
    hi User4 ctermfg=black ctermbg=magenta cterm=none     | " Magenta background
    hi User5 ctermfg=black ctermbg=cyan cterm=none        | " Cyan background
endif

augroup StatusLine                                        | " Set simpler statusline for help,netrw,... buffers
    autocmd!
    autocmd FileType help,netrw setlocal statusline=%2*%(\ %{&filetype}\ %)
augroup END


" Notes:
"   %(...%) defines an item group;
"   when all *items* in the group are empty,
"   the whole group is empty

