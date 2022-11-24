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

set statusline+=%0*%=                                        | " Switch to right-side

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

if g:colors_name != "romes"                                  | " Highlight statusline when using a normal colorscheme

    hi link User1 Visual
    hi link User2 User1
    hi link User3 User1
    hi link User4 Normal
    hi link User5 User4
endif

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

