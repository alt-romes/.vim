" disable ghc integration
let b:ale_linters = ['cabal_ghc', 'ghc_mod', 'hdevtools', 'hie', 'hlint', 'hls', 'stack_build', 'stack_ghc']

set expandtab tabstop=2 shiftwidth=2      | " Indent by 2 spaces

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

nnoremap <leader>s :call Swap()<cr>
