"==========================================
"|             romes vimrc                |
"==========================================

" TODO: (WIP)
function! GetRandomSentence() abort
  return system("sentences -...")
endfunction


set nocompatible  | " enter the current millenium
syntax on
filetype plugin indent on
set relativenumber | " for normal line numbers use `number` instead
set shiftwidth=4 tabstop=4 expandtab | " 1 tab = 4 spaces
set undofile undodir=$HOME/.vim/undofiles
set ignorecase incsearch hlsearch
set wildmenu
set mouse=a
set nowrap
set autoread
set autoindent
set modeline
set exrc secure
set spelllang=pt,en_gb | " (don't forget :set spell)
set regexpengine=0
set path+=**


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
