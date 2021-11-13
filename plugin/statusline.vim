" Author:       romes

set laststatus=2 " always enable statusline
set noshowmode

let mode_map = {
      \     'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
      \     'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'
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


set statusline=%1*\ %{mode_map[mode()]}\      " Mode

set statusline+=%0*%(\ %r%)                   " Read-only flag
set statusline+=\ %t\                         " File name
set statusline+=%(%M\ %)                      " Modified flag

set statusline+=%2*\ %n\                      " Buffer number

set statusline+=%0*%=                         " Switch to right-side

set statusline+=%2*%(\ %{&filetype}\ %)       " Filetype

set statusline+=%0*%(\ %{FileSize()}\ \|%)    " File size
set statusline+=%(\ %{&fenc?&fenc:&enc}\ \|%) " Encoding
set statusline+=\ %p%%\                       " Percentage

set statusline+=%3*\ %3l:%-2c\                " Line:Column


hi StatusLine ctermfg=white ctermbg=none cterm=none
hi StatusLineNC ctermfg=black ctermbg=white cterm=inverse

hi User1 ctermfg=black ctermbg=1 cterm=none | " Red
hi User2 ctermfg=black ctermbg=3 cterm=none | " Yellow
hi User3 ctermfg=black ctermbg=4 cterm=none | " Blue


" INFO:
"   %(...%) defines an item group;
"   when all *items* in the group are empty, the whole group is empty

