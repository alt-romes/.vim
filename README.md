# Getting started

```
cd $HOME
git clone --recurse-submodules https://github.com/alt-romes/.vim
```

# Included plugins

| Plugin name           | Repository                              | Description                  |
| ---                   | ---                                     | ---                          |
| ALE                   | https://github.com/dense-analysis/ale   | LSP integration              |
| Tabular               | https://github.com/godlygeek/tabular    | Table creation               |
| vim-commentary        | https://github.com/tpope/vim-commentary | Minimalist commenting plugin |
| vim-surround          | https://github.com/tpope/vim-surround   | Mappings for "surrounding"   |
| vim-polyglot          | https://github.com/sheerun/vim-polyglot | Language pack                |
| emmet-vim (to be opt) | https://github.com/mattn/emmet-vim      | HTML and CSS                 |

---

| Action              | Keys                  |
| ------------------- | --------------------- |
| Enable ALE          | <kbd><leader>a</kbd>  |
| Toggle File Browser | <kbd><leader>t</kbd>  |
| Comment             | <kbd>gc<motion></kbd> |
| Comment Line        | <kbd>gcc</kbd>        |
| Toggle all folds    | <kbd><leader>f</kbd>  |
| Create Fold         | <kbd>zf</kbd>         |
| Toggle fold         | <kbd>za</kbd>         |

---

| Netrw Action               | Keys             |
| -------------------------- | ---------------- |
| Open in Current Window     | <kbd>enter</kbd> |
| Open in New Tab            | <kbd>t</kbd>     |
| Open in New Vertical Split | <kbd>v</kbd>     |

---

Tabularize example...

```vim
set statusline=%1*\ %{mode_map[mode()]}\    " Mode
set statusline+=%0*%(\ %r%)                    " Read-only flag
set statusline+=\ %t\                       " File name
set statusline+=%(%M\ %)                    " Modified flag
set statusline+=%2*\ %n\                 " Buffer number
set statusline+=%0*%=                       " Switch to right-side
set statusline+=%2*%(\ %{&filetype}\ %)      " Filetype
set statusline+=%0*%(\ %{FileSize()}\ \|%)     " File size
set statusline+=%(\ %{&fenc?&fenc:&enc}\ \|%) " Encoding
set statusline+=\ %p%%\                 " Percentage
set statusline+=%3*\ %3l:%-2c\              " Line:Column
```

Tabularize against `"` by selecting these lines and executing `:Tabularize /"`
```vim
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
```

---

## Markers

For latex slides, use
```
set foldmethod=marker foldmarker=\\begin{frame},\\end{frame}
```
Additionally, add
```
% vim: foldmethod=marker foldmarker=\\begin{frame},\\end{frame}
```
To the bottom of the file to set that option for that file always
