Tabularize example...

Statusline definition with comments
```vim
set statusline=%1*\ %{mode_map[mode()]}\   " Mode

set statusline+=%2*
set statusline+=%(\ %r%)      " Read-only flag
set statusline+=\ %t\        " File name
set statusline+=%(%M\ %)   " Modified flag

set statusline+=%3*%=              " Switch to right-side
set statusline+=%(\ %{&filetype}\ \|%) " Filetype
set statusline+=%(\ %n\ \|%)    " Buffer number
set statusline+=%(\ %{&fileencoding?&fileencoding:&encoding}\ \|%) " Encoding
set statusline+=%(\ %{&fileformat}\ %) " Fileformat

set statusline+=%4*\ %3p%%\        " Percentage
set statusline+=%5*\ %3l:%-2c\     " Line:Column
```

Tabularize against `"` by selecting these lines and executing `:Tabularize /"`
```vim
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
```
