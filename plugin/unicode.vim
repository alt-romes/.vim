
" autocmd FileType * call DefUnicodeMaps()

" fun! DefUnicodeMaps()

"     " " Don't define mappings when actually writing \LaTeX
"     " if &ft =~ 'tex\|latex'
"     "     return
"     " endif

"     inoremap <buffer> <c-i>forall ∀
"     inoremap <buffer> <c-i>to →
"     inoremap <buffer> <c-i>lambda λ
"     inoremap <buffer> <c-i>Sigma Σ
"     inoremap <buffer> <c-i>exists ∃
"     inoremap <buffer> <c-i>equiv ≡

" endfun
