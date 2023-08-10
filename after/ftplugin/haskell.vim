" For Haskell Files, we synchronize syntax based on Haskell Block Comments
" This will fix syntax highlighting for large multi-line comment blocks
" This doesn't work: syntax sync ccomment haskellBlockComment
" We simply take the pluge and sync from start, because it's so important to
" get correct highlighting in GHC Notes
autocmd BufEnter * :syntax sync fromstart

