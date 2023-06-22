let b:ale_linters = ['hls']

set expandtab tabstop=2 shiftwidth=2      | " Indent by 2 spaces

let g:ale_haskell_hls_config = {'haskell': {'formattingProvider': 'fourmolu'}}

" For Haskell Files, we synchronize syntax based on Haskell Block Comments
" This will fix syntax highlighting for large multi-line comment blocks
" This doesn't work: syntax sync ccomment haskellBlockComment
" We simply take the pluge and sync from start, because it's so important to
" get correct highlighting in GHC Notes
syntax on
syntax sync fromstart

" call ale#linter#Define('haskell', {
" \   'name': 'ghc-dev',
" \   'output_stream': 'stderr',
" \   'executable': '/Users/romes/ghc-dev/ghc/hadrian/ghci',
" \   'command': '/Users/romes/ghc-dev/ghc/hadrian/ghci #',
" \   'callback': 'ale#handlers#haskell#HandleGHCFormat',
" \})


" Useful mappings
function! Swap()
    execute "normal! vab\<Esc>"
    '<,'>s/(\(.*\), \(.*\))/(\2, \1)/
    nohlsearch
    normal gvv
endfunction

" nnoremap <leader>s :call Swap()<cr>
