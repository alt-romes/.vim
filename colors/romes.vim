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
" packadd! wal.vim                                             | " Add optional wal.vim to runtimepath
" runtime colors/wal.vim                                       | " Load colorscheme (wal)

hi Normal ctermbg=NONE ctermfg=7
hi NonText ctermbg=NONE ctermfg=0
hi Comment ctermbg=NONE ctermfg=8
hi Conceal ctermbg=NONE
hi Constant ctermbg=NONE ctermfg=3
hi Error ctermbg=1 ctermfg=7
hi Identifier ctermbg=NONE ctermfg=1 cterm=BOLD
hi Ignore ctermbg=8 ctermfg=0
hi PreProc ctermbg=NONE ctermfg=3
hi Special ctermbg=NONE ctermfg=6
hi Statement ctermbg=NONE ctermfg=1
hi String ctermbg=NONE ctermfg=2
hi Number ctermbg=NONE ctermfg=3
hi Todo ctermbg=2 ctermfg=0
hi Type ctermbg=NONE ctermfg=3
hi Underlined ctermbg=NONE ctermfg=1 cterm=underline
hi StatusLine ctermbg=7 ctermfg=0
hi StatusLineNC ctermbg=8 ctermfg=0
hi TabLine ctermbg=NONE ctermfg=8
hi TabLineFill ctermbg=NONE ctermfg=8
hi TabLineSel ctermbg=4 ctermfg=0
hi TermCursorNC ctermbg=3 ctermfg=0
hi VertSplit ctermbg=8 ctermfg=0
hi Title ctermbg=NONE ctermfg=4
hi CursorLine ctermbg=2 ctermfg=0
hi LineNr ctermbg=NONE ctermfg=8
hi CursorLineNr ctermbg=NONE ctermfg=8
hi helpLeadBlank ctermbg=NONE ctermfg=7
hi helpNormal ctermbg=NONE ctermfg=7
hi Visual ctermbg=0 ctermfg=15 cterm=reverse term=reverse
hi VisualNOS ctermbg=NONE ctermfg=1
hi Pmenu ctermbg=8 ctermfg=7
hi PmenuSbar ctermbg=6 ctermfg=7
hi PmenuSel ctermbg=4 ctermfg=0
hi PmenuThumb ctermbg=8 ctermfg=8
hi FoldColumn ctermbg=NONE ctermfg=7
hi Folded ctermbg=NONE ctermfg=8
hi WildMenu ctermbg=2 ctermfg=0
hi SpecialKey ctermbg=NONE ctermfg=8
hi DiffAdd ctermbg=NONE ctermfg=2
hi DiffChange ctermbg=NONE ctermfg=8
hi DiffDelete ctermbg=NONE ctermfg=1
hi DiffText ctermbg=NONE ctermfg=4
hi IncSearch ctermbg=3 ctermfg=0
hi Search ctermbg=3 ctermfg=0
hi Directory ctermbg=NONE ctermfg=4
hi MatchParen ctermbg=1 ctermfg=8
hi ColorColumn ctermbg=4 ctermfg=0
hi signColumn ctermbg=NONE ctermfg=4
hi ErrorMsg ctermbg=NONE ctermfg=8
hi ModeMsg ctermbg=NONE ctermfg=2
hi MoreMsg ctermbg=NONE ctermfg=2
hi Question ctermbg=NONE ctermfg=4
hi WarningMsg ctermbg=1 ctermfg=0
hi Cursor ctermbg=NONE ctermfg=8
hi Structure ctermbg=NONE ctermfg=5
hi CursorColumn ctermbg=8 ctermfg=7
hi ModeMsg ctermbg=NONE ctermfg=7
hi SpellBad ctermbg=NONE ctermfg=1 cterm=underline
hi SpellCap ctermbg=NONE ctermfg=4 cterm=underline
hi SpellLocal ctermbg=NONE ctermfg=5 cterm=underline
hi SpellRare ctermbg=NONE ctermfg=6 cterm=underline
hi Boolean ctermbg=NONE ctermfg=5
hi Character ctermbg=NONE ctermfg=1
hi Conditional ctermbg=NONE ctermfg=5
hi Define ctermbg=NONE ctermfg=5
hi Delimiter ctermbg=NONE ctermfg=5
hi Float ctermbg=NONE ctermfg=5
hi Include ctermbg=NONE ctermfg=4
hi Keyword ctermbg=NONE ctermfg=5
hi Label ctermbg=NONE ctermfg=3
hi Operator ctermbg=NONE ctermfg=7
hi Repeat ctermbg=NONE ctermfg=3
hi SpecialChar ctermbg=NONE ctermfg=5
hi Tag ctermbg=NONE ctermfg=3
hi Typedef ctermbg=NONE ctermfg=3
hi ALEErrorSign ctermbg=NONE ctermfg=1
hi ALEWarningSign ctermbg=NONE ctermfg=3
hi ALEError ctermbg=NONE ctermfg=1
hi ALEWarning ctermbg=NONE ctermfg=3


hi TabLineSel   ctermfg=black   ctermbg=yellow cterm=none
" hi link TabLineSel User2
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
