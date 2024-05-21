" Author: romes

set laststatus=2                                             | " Always enable statusline
set noshowmode                                               | " Don't display -- MODE --

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

set statusline=%1*\ %{mode_map[mode()]}\                     | " Mode

if exists('g:statusline_more_colors') && g:statusline_more_colors
    set statusline+=%4*
else
    set statusline+=%0*
endif
set statusline+=\ %t\                                        | " File name
set statusline+=%(%M\ %)                                     | " Modified flag

set statusline+=%2*\ %n\                                     | " Buffer number

set statusline+=%0*%(\ %r%)                                  | " Read-only flag
set statusline+=%(\ %h%)                                     | " Help flag
set statusline+=%(\ %w%)                                     | " Preview flag

" Temp. set to %6 instead of %0 to hide stuff
set statusline+=%6*%=                                        | " Switch to right-side

" set statusline+=%(\ %{FugitiveStatusline()}\ %)              | " Fugitive
set statusline+=%2*%(\ %{&filetype}\ %)                      | " Filetype

if exists('g:statusline_more_colors') && g:statusline_more_colors
    set statusline+=%5*
else
    set statusline+=%0*
endif
set statusline+=%(\ %{FileSize()}\ \|%)                      | " File size
set statusline+=%(\ %{&fenc?&fenc:&enc}\ \|%)                | " Encoding
set statusline+=\ %p%%\                                      | " Percentage

set statusline+=%3*\ %3l:%-2c\                               | " Line:Column

augroup StatusLine                                           | " Set simpler statusline for help,netrw,... buffers
    autocmd!

    " Special statusline for help,netrw
    autocmd FileType help,netrw setlocal statusline=%2*%(\ %{&filetype}\ %)

    " When the colorscheme is changed, reload statusline
    autocmd ColorScheme * runtime plugin/statusline.vim
augroup END

func ReverseHiGroup(groupSrc, groupDst)
    let id = synIDtrans(hlID(a:groupSrc))
    for mode in ['cterm', 'gui']
        for g in ['fg', 'bg']
            exe 'let '. mode.g. "=  synIDattr(id, '". g."#', '". mode. "')"
            exe "let ". mode.g. " = empty(". mode.g. ") ? 'NONE' : ". mode.g
        endfor
    endfor
    exe printf('hi! %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s', a:groupDst, ctermbg, ctermfg, guibg, guifg)
endfunc

" Set the User highlight to the reverse of normal
" call ReverseHiGroup("Type", "User1")
" call ReverseHiGroup("StatusLine", "User2")
" call ReverseHiGroup("StatusLine", "User3")

if !exists("g:colors_name") || g:colors_name != "romes"     | " Highlight statusline when using a normal colorscheme
    hi link User1 Special
    hi link User2 Identifier
    hi link User3 Blue
    hi link User4 Constant
    hi link User5 Statement
    hi link User6 User5
endif

" Highlights for specific colorschemes

" if exists("g:colors_name") && g:colors_name == 'github'
"     highlight link User1 airline
"     highlight link ALEWarning CocWarningHighlight
"     highlight link ALEWarning CocWarningHighlight
" endif

" ======== Notes ================
"   1 - %(...%) defines an item group;
"   when all *items* in the group are empty,
"   the whole group is empty
" 
"   2 - StatusLineNC (non-current statusline) is equal
"   to the difference between User{N} and StatusLine,
"   e.g. to have an italic StatusLine and a normal
"   StatusLineNC, StatusLine AND User{N} should
"   both have cterm=italic (italic - italic = none)

