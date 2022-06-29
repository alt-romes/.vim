" romes' vimrc
" Author: romes

" ======== Options ============= {{{

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
set modeline modelines=4                  | " Check first and last file lines for modelines (that :set options)
set exrc secure                           | " Read current directory .vimrc (with security-related limitations)
set spelllang=pt_pt,en_gb                 | " Spell languages to use when spell checking (:set spell)
set regexpengine=0                        | " Automatically select regexp engine
set undofile undodir=$HOME/.vim/undofiles | " Persistent undo (:h persistent-undo)
set backspace=indent,eol,start            | " Make backspace work as expected
set path+=**                              | " Recursively search subdirectories (when using gf, :tabfind, et cetera)
set nofoldenable foldmethod=marker        | " Fold with markers (e.g. set in a modeline to marker), open by default

let g:tex_flavor='latex'                  | " Set TeX flavor to LaTeX

let g:statusline_more_colors=0            | " Use more colors in the custom statusline
colorscheme romes                         | " Select colorscheme
" packadd! everforest
" colorscheme everforest

highlight Comment cterm=italic            | " Highlight comments in italic

" }}}
" ======== Normal Mode ========= {{{
"
"   <C-l>
"       clear the highlighting of :set hlsearch.
"   <leader>f
"       toggle folds
"   <leader>cd
"       change to a random dark colorscheme
"   <leader>cl
"       change to a random light colorscheme
"   <leader>c
"       write line to macOS clipboard
"   <leader>a
"       enable ALE (LSP client) and set omnifunc " :set omnifunc=ale#completion#OmniFunc<CR>
"   <leader>h
"       show ALE reported error/warning detail/help
"   <leader>k
"       print information about the symbol at the cursor
"       todo: somehow remap to K (as done with manpages)
"   <leader>t
"       Toggle netrw file browser in the directory of the file
"   <leader>g
"       Toggle Shizukesa
"

nnoremap <silent> <C-l> :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<cr><cr><C-l>
nnoremap <silent> <leader>f :set fen!<cr>
nnoremap <silent> <leader>cb :!wal -i ~/Pictures/backgrounds --saturate 0.8<cr><cr>
nnoremap <silent> <leader>cw :!wal -l -i ~/Pictures/backgrounds --saturate 0.8<cr><cr>
nnoremap <silent> <leader>cd :!wal -f random<cr><cr>
nnoremap <silent> <leader>cl :!wal -f random_light<cr><cr>
noremap  <silent> <leader>c :w !pbcopy<cr><cr>
nnoremap <silent> <leader>a :ALEEnable<cr>
nnoremap <silent> <leader>h :ALEDetail<cr>
nnoremap <silent> <leader>ca :ALECodeAction<cr>
nnoremap <silent> <C-k> :ALEHover<cr><C-w>k
nnoremap <silent> <leader>t :call ToggleNetrw()<cr>
nnoremap <silent> <leader>g :call Shizukesa()<cr>
nnoremap <silent> <leader>m :make<cr><cr><cr>
nnoremap <silent> <leader>er :vsplit ~/.vim/README.md<cr>

" }}}
" ======== Insert Mode ========= {{{
"
"   <C-l>
"       fix last spelling mistake
"

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" }}}
" ======== Visual Mode ========= {{{
"
"   J
"       move visual selection up one line
"   K
"       move visual selection down one line
"

vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" }}}
" ======== Plugins ============= {{{

" ======== Netrw =============== {{{

let g:romes_netrw_enabled = 0                  | " Global netrw variable for toggle
let g:netrw_banner = 0                         | " Disable netrw banner
let g:netrw_liststyle = 3                      | " Tree style listing
let g:netrw_altv = 1
" let g:netrw_browse_split = 4                   | " Open file in previous window by default
let g:netrw_winsize = 20                       | " Set initial size of new windows to 20%
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' | " Hide dotfiles on load (use gh to show)

function! ToggleNetrw()
    if g:romes_netrw_enabled
        Lexplore
        let g:romes_netrw_enabled = 0
    else
        Lexplore %:p:h
        let g:romes_netrw_enabled = 1
    endif
endfunction

" }}}
" ======== ALE ================= {{{

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

let g:ale_floating_preview = 1                                  | " Use floating window preview

" let g:ale_completion_enabled = 1                              | " TODO: help ale-completion
" let g:ale_completion_autoimport = 1                           | " Automatically import external modules for completion

" }}}
" ======== Polyglot ============ {{{

let g:polyglot_disabled = ['autoindent']                        | " Disable autoindent from vim-polyglot

" }}}
" ======== Latex Unicoder ====== {{{
let g:unicoder_no_map = 1
nnoremap <C-i> :call unicoder#start(0)<CR>
vnoremap <C-i> :<C-u>call unicoder#selection()<CR>
" }}}

" }}}
" ======== Other =============== {{{

" Set syntax completion function for filetypes without a completion function
autocmd Filetype *
    \	if &omnifunc == "" |
    \		setlocal omnifunc=syntaxcomplete#Complete | " :help ft-syntax-omni
    \	endif

" }}}
" ======== Notes =============== {{{
"   Some sensible options relevant for good language support are provided
"   by vim-polyglot's 'sensible' component They can be disabled with
"   let g:polyglot_disabled = ['sensible'], but should be set manually because
"   they are relevant
"
"   Folds can be created automatically for delimited blocks (see :h fmr)
"   The foldmethod and foldmarker needed to create them can be set in a modeline
"       /* vim: foldmethod=marker fmr={,} */
"   The <leader>f mapping can be used to toggle all folds
"
"   <leader>s
"       " echo sentence in a random lanuage from languages/sentences.db
"       noremap <silent> <leader>s :echom system("sentences -o -n")<CR>
"
" }}}}

" vim: fdm=marker
