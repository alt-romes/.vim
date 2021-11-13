"==========================================
"|             romes vimrc                |
"==========================================

" TODO: (WIP)
function! GetRandomSentence() abort
  return system("sentences -...")
endfunction

set relativenumber

" Fix with first dictionary option (don't forget :set spell)
set spelllang=pt,en_gb
" <C-l> fixes last spelling mistake
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

set autoread

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

iabbrev adn and

command! MakeTags !ctags -R .
" use Ctrl+] to jump to tag under cursor
" use g(Ctrl+]) for ambiguous tags
" use Ctrl+t to jump the tag stack

set path+=**

nnoremap <leader>cl :!wal -f random_light<cr><cr>
nnoremap <leader>cd :!wal -f random<cr><cr>

" Move visual selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

"==========================================
"|               Colors                   |
"==========================================

" syntax highlighting and colors
syntax on

" set termguicolors     " enable true colors support

" enable themes (packadd! name)
packadd! wal.vim

" choose random colorscheme
let ltime = 1 " localtime()
let colorschemes = ['default', 'wal']
" set colorscheme
execute 'colorscheme' colorschemes[ltime % (len(colorschemes)) ]

"==========================================
"|            Customization               |
"==========================================

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" enter the current millenium
set nocompatible

" enable filetype detection, indention and plugins for specific filetypes
filetype plugin indent on

" copy to macOS clipboard with <leader>c
noremap <silent> <leader>c :w !pbcopy<CR><CR>

set autoindent

" 1 tab = 4 spaces
set sw:4 ts:4 expandtab

" numbered lines
set number

" set no wrap so lines overflow border of screen
set nowrap

" search ignore case
set ignorecase


" " highlight search results
" set hlsearch

" allow mouse scrolling 
set mouse=a

" persistent undo
set undofile

" use file-embedded configuration (:h modeline)
set modeline

" specify undo directory
set undodir=$HOME/.vim/undofiles

" enable autocomplete with syntax (usage: <C-X><C-O>)
set omnifunc=syntaxcomplete#Complete " use Ale completion below...

" create command to print sentence from languages/sentences.db
noremap <silent> <leader>s :echom system("sentences -o -n")<CR>

" create command to switch .asm syntax to rgbasm
" map <silent> <leader>s :set syntax=rgbasm<CR>

" enable menus
set wildmenu    " :h wildmenu

" recognize .tex as latex
let g:tex_flavor='latex'

" enable project specific .vimrc
set exrc
set secure

"==========================================
"|               Plugins                  |
"==========================================
"
" Adding plugins:
"   cd ~/.vim/pack/romes/start
"   git submodule add https://github.com/pluginowner/plugin
"   (alternatively run .vim/install-plugin.sh)
" Updating plugins:
"   git submodule update

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

" does nothing??
" let g:ale_set_highlights = 0

" Create shortcut to run ALEHover (ctrl+k) and switch panes to it
nnoremap <silent> <C-K> :ALEHover<CR><C-W>k

" configure messages
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] %s : %linter%'

" --------------------------------

"disable shiftwidth changing
let g:polyglot_disabled = ['autoindent']

" fix vim polyglot groovy file editing (what does it really do to regex?)
set re=0

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

" Cucumbertables.vim :: tpope script to create tables using Tabular
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
