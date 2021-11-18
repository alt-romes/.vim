let b:ale_linters_ignore = ['checkstyle', 'eclipselsp', 'javalsp', 'pmd']

setlocal makeprg=javac\ %
setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
