" romes.vim -- colorscheme
" Author: romes

let g:colors_name = 'romes'                                  | " Colorscheme name

if !exists('g:statusline_more_colors')
    let g:statusline_more_colors = 1                         | " Highlight more groups with more colors
endif
if !exists('g:statusline_highlight')
    let g:statusline_highlight   = 1 + localtime() % 2       | " Statusline highlighting mode (available: 1, 2)
endif


                                                             " Load the base colorscheme
packadd! wal.vim                                             | " Add optional wal.vim to runtimepath
runtime colors/wal.vim                                       | " Load colorscheme (wal)



hi TabLineSel   ctermfg=black   ctermbg=yellow cterm=none
hi TabLine      ctermfg=white   ctermbg=none   cterm=none
hi TabLineFill  ctermfg=white   ctermbg=none   cterm=none

if g:statusline_highlight == 1
    hi StatusLine ctermfg=white ctermbg=none cterm=none
    hi StatusLineNC ctermfg=black ctermbg=none cterm=reverse
    hi User1 ctermfg=black ctermbg=red cterm=none            | " Red background
    hi User2 ctermfg=black ctermbg=yellow cterm=none         | " Yellow background
    hi User3 ctermfg=black ctermbg=blue cterm=none           | " Blue background
    hi User4 ctermfg=black ctermbg=magenta cterm=none        | " Magenta background
    hi User5 ctermfg=black ctermbg=cyan cterm=none           | " Cyan background

elseif g:statusline_highlight == 2
    hi StatusLine ctermfg=white ctermbg=none cterm=bold
    hi StatusLineNC ctermfg=black ctermbg=none cterm=none
    hi User1 ctermfg=red ctermbg=none cterm=italic,bold      | " Red foreground
    hi User2 ctermfg=yellow ctermbg=none cterm=italic,bold   | " Yellow foreground
    hi User3 ctermfg=blue ctermbg=none cterm=italic,bold     | " Blue foreground
    hi User4 ctermfg=magenta ctermbg=none cterm=italic,bold  | " Magenta foreground
    hi User5 ctermfg=cyan ctermbg=none cterm=italic,bold     | " Cyan foreground

endif

hi VertSplit cterm=none ctermbg=none ctermfg=darkgrey
