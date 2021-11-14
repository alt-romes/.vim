" romes' vimrc
" Author: romes

" ======== Options ============= "

set nocompatible                          | " Enter the current millennium

filetype plugin indent on                 | " Detect filetype and load according plugins
syntax on                                 | " Enable syntax highlighting

set number relativenumber                 | " Set relative numbered lines
set expandtab tabstop=4 shiftwidth=4      | " Indent by 4 spaces
set hlsearch ignorecase incsearch         | " Highlight case-insensitive search while typing
set wildmenu                              | " Display command-line completion menu
set mouse=a                               | " Enable all mouse modes
set nowrap sidescroll=12 sidescrolloff=4  | " Disable line wrapping and set smoother horizontal scroll
set autoread                              | " Automatically re-read files changed outside if not changed inside vim
set autoindent                            | " Indent new lines according to previous line.
set modeline modelines=5                  | " Check first and last file lines for modelines (that :set options)
set exrc secure                           | " Read current directory .vimrc (with security-related limitations)
set spelllang=pt_pt,en_gb                 | " Spell languages to use when spell checking (:set spell)
set regexpengine=0                        | " Automatically select regexp engine
set undofile undodir=$HOME/.vim/undofiles | " Persistent undo (:h persistent-undo)
set backspace=indent,eol,start            | " Make backspace work as expected
set path+=**                              | " Recursively search subdirectories (when using gf, :tabfind, et cetera)

let g:tex_flavor='latex'                  | " Set TeX flavor to LaTeX

packadd! wal.vim                          | " Enable theme in pack/themes/opt
colorscheme wal                           | " Select enabled theme (wal)

highlight Comment cterm=italic            | " Highlight comments in italic

" ======== Normal Mode ========= "

" :<C-l>: clear the highlighting of :set hlsearch.
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" :<leader>cd: change to a random dark colorscheme
nnoremap <leader>cd :!wal -f random<cr><cr>
" :<leader>cl: change to a random light colorscheme
nnoremap <leader>cl :!wal -f random_light<cr><cr>
" :<leader>c: write line to macOS clipboard
noremap <silent> <leader>c :w !pbcopy<CR><CR>
" :<leader>a: enable ALE (Language Server Protocol client)
nnoremap <silent> <leader>a :ALEEnable<CR>:set omnifunc=ale#completion#OmniFunc<CR>
" :<leader>h: show ALE reported error/warning detail/help
nnoremap <silent> <leader>h :ALEDetail<CR>
" :<leader>k: print information about the symbol at the cursor
" # TODO: somehow remap to :K: (as done with manpages)
nnoremap <silent> <C-K> :ALEHover<CR><C-W>k
" :<leader>t: Toggle netrw file browser in the directory of the file (todo: toggle())
nnoremap <leader>t :Lexplore %:p:h<CR>
" :<leader>g: Toggle Goyo
nnoremap <leader>g :Goyo<cr>

" ======== Insert Mode ========= "

" :<C-l>: fix last spelling mistake
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" :|: automatically align tables of form | .* | ... |
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" ======== Visual Mode ========= "

" :J: move visual selection up one line
vnoremap J :m '>+1<cr>gv=gv
" :K: move visual selection down one line
vnoremap K :m '<-2<cr>gv=gv

" ======== Plugins ============= "

" ======== Netrw =============== "

let g:netrw_banner = 0                                          | " Disable netrw banner
let g:netrw_liststyle = 3                                       | " Tree style listing
let g:netrw_browse_split = 4                                    | " Open file in previous window by default
let g:netrw_winsize = 20                                        | " Set initial size of new windows to 20%

" ======== ALE ================= "

let g:ale_enabled = 0                                           | " Disable ALE by default

                                                                " Slow down automatic linting
let g:ale_lint_on_text_changed = 'never'                        | " Don't lint on text changed
let g:ale_lint_on_insert_leave = 0                              | " Don't lint when leaving insert mode
let g:ale_lint_on_enter = 0                                     | " Don't lint when entering a buffer window

let g:ale_echo_msg_error_str = 'E'                              | " String used for %severity% for errors
let g:ale_echo_msg_warning_str = 'W'                            | " String used for %severity% for warnings
let g:ale_echo_msg_info_str = 'I'                               | " String used for %severity% for info
let g:ale_echo_msg_format = '[%severity%%:code%] %s : %linter%' | " Message format for echoed messages

let g:ale_lsp_suggestions = 1                                   | " Show hints/suggestions in addition to warnings and errors

" ======== Polyglot ============

let g:polyglot_disabled = ['autoindent']                        | " Disable autoindent from vim-polyglot


" ======== To Clean Up =========

" let g:ale_completion_enabled = 1 # don't enable completion, just show it
" when omnifunc is pressed (ctrl+x>ctrl+o)
let g:ale_completion_autoimport = 1 " automatic import from external modules


" Set filetype for pandoc markdown
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" cucumbertables.vim :: tpope script to create tables using Tabular
function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

" :help ft-syntax-omni ||| alternative: only use completion with ale
if has("autocmd") && exists("+omnifunc")
autocmd Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
endif

" TODO: (WIP)
" " :<leader>s: echo sentence in a random lanuage from languages/sentences.db
" noremap <silent> <leader>s :echom system("sentences -o -n")<CR>
" function! GetRandomSentence() abort
"   return system("sentences -...")
" endfunction

" Note:
"   Some sensible options relevant for good language support are provided
"   by vim-polyglot's 'sensible' component They can be disabled with
"   let g:polyglot_disabled = ['sensible'], but should be set manually because
"   they are relevant


