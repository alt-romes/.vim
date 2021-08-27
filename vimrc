"==========================================
"|             romes vimrc                |
"==========================================

" cheatsheet

" > insert non-ascii value: in insert mode press ctrl+V followed by x00-FF (max)
" :help i_CTRL-V_digit


"==========================================
"|               Colors                   |
"==========================================

" syntax highlighting and colors
syntax on

set termguicolors     " enable true colors support

" enable themes (packadd! name)
packadd! wal.vim

" settings for schemes

" choose random colorscheme
let ltime = 1 " localtime()
let colorschemes = ['default', 'wal']
let linecolors = ['default', 'wal']
" set lightline bar color (use it on the #plugin section)
let lightlinecolortheme = linecolors[ltime % (len(linecolors)) ]
" set colorscheme
execute 'colorscheme' colorschemes[ltime % (len(colorschemes)) ]


"==========================================
"|            Custom Commands             |
"==========================================
" Start commands with R for romes

" Make background transparent
command RTransparentBackground hi Normal guibg=NONE ctermbg=NONE

command RGitShortlog :!git shortlog -n %

"==========================================
"|            Customization               |
"==========================================

" copy to macOS clipboard with <leader>c
map <silent> <leader>c :w !pbcopy<CR><CR>

" autoindent
set autoindent

" 1 tab = 4 spaces
set sw:4 ts:4 expandtab

" numbered lines
set nu

" set no wrap so lines overflow border of screen
set nowrap

" search ignore case
set ignorecase

" right bottom see cursor position
set ruler

" " highlight search results
" set hlsearch

" " remove highlight from search with leader+space
" nnoremap <nowait><silent> <leader><ESC> :noh<CR>

" allow mouse scrolling 
set mouse=a

" persistent undo
set undofile

" specify undo directory
set undodir=$HOME/.vim/undofiles

" enable filetype detection | required by: taglist
filetype on

" enable plugins for specific filetypes | required by: cvim
filetype plugin on

" enable autocomplete with syntax (usage: <C-X><C-O>)
" set omnifunc=syntaxcomplete#Complete " use Ale completion below...
" use Ctrl + j for omnicomplete " disabled, use <C-X><C-O>
" imap <C-j> <C-X><C-O>

" create command to print sentence from languages/sentences.db
map <silent> <leader>s :echom system("sentences -o -n")<CR>

" create command to switch .asm syntax to rgbasm
" map <silent> <leader>s :set syntax=rgbasm<CR>

" fix vim polyglot groovy file editing (what does it really do to regex?)
set re=0

" enable menus
source $VIMRUNTIME/menu.vim
set wildmenu    " :h wildmenu
set cpo-=<      " compatability option which i don't really understand

" recognize .tex as latex
let g:tex_flavor='latex'

"==========================================
"|               Plugins                  |
"==========================================
"
" Adding plugins:
"   cd ~/control/dotfiles/public/.vim/pack/romes/start
"   git submodule add https://github.com/pluginowner/plugin
"   (alternatively run .vim/install-plugin)
" Updating plugins:
"   git submodule update


""" Ale: LSP integration:

" Toggle ALE - start disabled by default, use \a (leader+a)
let g:ale_enabled = 0
nmap <silent> <leader>a :ALEEnable<CR>

" Show error/warning detail with leader+h
nmap <silent> <leader>h :ALEDetail<CR>

" let g:ale_completion_enabled = 1 # don't enable completion, just show it
" when omnifunc is pressed (ctrl+j or ctrl+x>ctrl+o)
set omnifunc=ale#completion#OmniFunc
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
nmap <silent> <C-K> :ALEHover<CR><C-W>k

" configure messages
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] %s : %linter%'


""" vim-snipmate : enable version 1 parser
let g:snipMate = { 'snippet_version' : 1 }

""" vim-commentary : creates comments with 'gc'


""" vim-auto-pair


""" vim-polyglot : syntax highlighting for a lot of langs

" required
set nocompatible

"disable shiftwidth changing
let g:polyglot_disabled = ['autoindent']

" required?
" filetype plugin indent on

""" vim-snipmate | dependencies: tlib_vim, vim-addon-mw-utils, vim-snippets
" no commands


""" Light Line

" Display bar
set laststatus=2

" Hide -- INSERT --
set noshowmode

" Extra components
let g:lightline = {
      \ 'colorscheme': lightlinecolortheme,
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [  'randsentence', 'fileformat', 'fileencoding', 'filetype', 'wordcount' ] ]
      \ },
      \ 'component': {
      \   'romes': 'hello there'
      \ },
      \ 'component_function': {
      \   'wordcount': 'LightlineWordCount',
      \ },
      \ }
function! LightlineWordCount() abort
  return wordcount().words . ' words'
endfunction

" TODO: (WIP)
      " \   'randsentence': 'GetRandomSentence',
function! GetRandomSentence() abort
  return system("echo -n 'hello world'")
endfunction

""" NERDTree

" Bind NERDTreeToggle to leader t, and open the directory for the file being edit
nnoremap <leader>t :NERDTreeToggle %:p:h<CR>

" Close window when NERDTree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


""" Goyo

" Bind Goyo to leader g
nnoremap <leader>g :Goyo<cr>

"==========================================
"|            Optional Plugins            |
"==========================================
"    (start them with :packadd plugin)
