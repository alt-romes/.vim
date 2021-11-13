" Author:       romes

set laststatus=2 " always enable statusline
set noshowmode

let mode_map = {
      \     'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
      \     'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'
      \   }

set statusline=%1*\ %{mode_map[mode()]}\                           " Mode

set statusline+=%2*
set statusline+=%(\ %r%)                                           " Read-only flag
set statusline+=\ %t\                                              " File name
set statusline+=%(%M\ %)                                           " Modified flag

set statusline+=%3*%=                                              " Switch to right-side
set statusline+=%(\ %{&filetype}\ \|%)                             " Filetype
set statusline+=%(\ %n\ \|%)                                       " Buffer number
set statusline+=%(\ %{&fileencoding?&fileencoding:&encoding}\ \|%) " Encoding
set statusline+=%(\ %{&fileformat}\ %)                             " Fileformat

set statusline+=%4*\ %3p%%\                                        " Percentage
set statusline+=%5*\ %3l:%-2c\                                     " Line:Column

" hi StatusLine ctermfg=black ctermbg=none cterm=none
hi StatusLineNC ctermfg=black ctermbg=black cterm=italic
hi User1 ctermfg=black ctermbg=red cterm=none
hi User2 ctermfg=black ctermbg=magenta cterm=none
hi User3 ctermfg=NONE ctermbg=NONE
hi User4 ctermfg=black ctermbg=blue
hi User5 ctermfg=black ctermbg=cyan


" INFO:
"   %(...%) defines an item group;
"   when all *items* in the group are empty, the whole group is empty
