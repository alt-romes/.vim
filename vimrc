" romes' vimrc
" Author: romes

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
set autoindent                            | " Indent according to previous line.
set modeline modelines=5                  | " Check first and last file lines for modelines (that :set options)
set exrc secure                           | " Read current directory .vimrc (with security-related limitations)
set spelllang=pt_pt,en_gb                 | " Spell languages to use when spell checking (:set spell)
set regexpengine=0                        | " Automatically select regexp engine
set undofile undodir=$HOME/.vim/undofiles | " Persistent undo (:h persistent-undo)
set backspace=indent,eol,start            | " Make backspace work as expected
set path+=**                              | " Recursively search subdirectories (when using gf, :tabfind, et cetera)


" TODO: (WIP)
function! GetRandomSentence() abort
  return system("sentences -...")
endfunction

" <C-l> fixes last spelling mistake
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

nnoremap <leader>cl :!wal -f random_light<cr><cr>
nnoremap <leader>cd :!wal -f random<cr><cr>

" Move visual selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" enable themes (packadd! name)
packadd! wal.vim

colorscheme wal

" copy to macOS clipboard with <leader>c
noremap <silent> <leader>c :w !pbcopy<CR><CR>

" create command to print sentence from languages/sentences.db
noremap <silent> <leader>s :echom system("sentences -o -n")<CR>

" recognize .tex as latex
let g:tex_flavor='latex'

"==========================================
"|               Plugins                  |
"==========================================
"
" Adding plugins:
"   cd ~/.vim/pack/romes/start
"   git submodule add https://github.com/pluginowner/plugin
"   (alternatively run .vim/install-plugin.sh)
" Updating plugins:
"   git submodule update --remote --recursive

" --------------------------------

""" Ale: LSP integration:

" Toggle ALE - start disabled by default, use \a (leader+a)
let g:ale_enabled = 0
nnoremap <silent> <leader>a :ALEEnable<CR>:set omnifunc=ale#completion#OmniFunc<CR>

" Show error/warning detail with leader+h
nnoremap <silent> <leader>h :ALEDetail<CR>

" let g:ale_completion_enabled = 1 # don't enable completion, just show it
" when omnifunc is pressed (ctrl+x>ctrl+o)
let g:ale_completion_autoimport = 1 " automatic import from external modules

" show suggestions
let g:ale_lsp_suggestions = 1

" slow down automatic linting
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0 

" disable background color on the sign column
let g:ale_change_sign_column_color = 0

" Create shortcut to run ALEHover (ctrl+k) and switch panes to it
nnoremap <silent> <C-K> :ALEHover<CR><C-W>k

" configure messages
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] %s : %linter%'

" --------------------------------

"disable shiftwidth changing
let g:polyglot_disabled = ['autoindent']


" --------------------------------

" Bind NERDTreeToggle to leader t, and open the directory for the file being edit
nnoremap <leader>t :NERDTreeToggle %:p:h<CR>

" Close window when NERDTree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" --------------------------------

" Set filetype for pandoc markdown
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" --------------------------------

" Bind Goyo to leader g
nnoremap <leader>g :Goyo<cr>

" --------------------------------

" cucumbertables.vim :: tpope script to create tables using Tabular
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

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

" Comments in italic
hi Comment cterm=italic

" :help ft-syntax-omni ||| alternative: only use completion with ale
if has("autocmd") && exists("+omnifunc")
autocmd Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
endif
