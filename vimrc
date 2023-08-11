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
set termguicolors                         | " When compiled with +termguicolors, use the gui colors in the terminal; to use the romes colorscheme you probably want to unset this, since it depends on the terminal non-gui colors
set clipboard^=unnamed                    | " Share clipboard between vim and system
set conceallevel=2                        | " Conceal level to hide typesetting details
set smartcase                             | " Will use case-sensitive if capital or \C letter is present
set smarttab                              | " Makes tabbing smarter will realize you have 2 vs 4, and default to tabstop/tabwidth when not obvious
set cursorline cursorlineopt=both         | " Highlight the line number of the cursor line (cursorlineopt=number is also good)


let g:tex_flavor='latex'                  | " Set TeX flavor to LaTeX

let g:statusline_more_colors=1            | " Use more colors in the custom statusline
let g:statusline_highlight=2              | " Set the highlighting mode for the statusline
" colorscheme romes                         | " Select colorscheme and set statusline

" Colorschemes
" Note: Either iTerm's colorscheme matches the colorscheme, or the transparent
" background must be disabled in the lines below.
packadd! everforest
packadd! nightfox.nvim
packadd! vim-colors-github
let g:everforest_background = 'medium'
let g:everforest_better_performance = 1
let g:github_colors_block_diffmark = 1
" colorscheme everforest
" colorscheme seoul256
" colorscheme xcodedarkhc
" colorscheme xcodedark
" colorscheme xcodelight
" colorscheme dawnfox
" colorscheme terafox
" colorscheme carbonfox
" colorscheme ayu
" colorscheme dayfox
" colorscheme nightfox
colorscheme github
set background=light

" highlight Normal ctermbg=NONE guibg=NONE  | " Use the terminal's background color - this requires the terminal background color to be that of the vim colorscheme
                                            " Good for transparent terminals!
" highlight Comment cterm=italic            | " Highlight comments in italic

" colorscheme romes

" ======== Lightline =========== {{{
" We're using lightline again, to get nice colorschemes and changing colors on
" changing modes, which was becoming harder using our custom plugin/statusline
"
" I still prefer my statusline, but the lightline colorschemes are better and
" are widely available with colorschemes
let g:lightline = {
  \ 'colorscheme': 'github',
  \ 'active': {
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'filetype', 'gitbranch', 'filesize', 'fileencoding' ] ]
  \ },
  \ 'component_function': {
  \     'filesize': 'FileSize',
  \     'gitbranch': 'FugitiveHead',
  \ }
  \ }
" }}}

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" }}}
" ======== GUI Options ========= {{{

" One very cool thing about the gui version is the colorscheme working
" flawlessly, without requiring changing things like the terminal colorscheme
" too.

set guifont=Menlo-Regular:h14             | " Set gui-vim font and size
set guioptions=egm                        | " Remove scroll bars, I basically removed 'l' and 'r' from the default settings


" }}}
" ======== Normal Mode ========= {{{
"
"   <C-l>
"       clear the highlighting of :set hlsearch.
"   <leader>gf
"       toggle folds
"   <leader>cd
"       change to a random dark colorscheme
"   <leader>cl
"       change to a random light colorscheme
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

nnoremap <silent> <C-j> <C-]>
nnoremap <silent> <C-l> :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<cr><cr><C-l>
nnoremap <silent> <leader>sf :set fen!<cr>
nnoremap <silent> <leader>cb :!wal -i ~/Pictures/backgrounds --saturate 0.8<cr><cr>
nnoremap <silent> <leader>cw :!wal -l -i ~/Pictures/backgrounds --saturate 0.8<cr><cr>
nnoremap <silent> <leader>cd :!wal -f random<cr><cr>
nnoremap <silent> <leader>cl :!wal -f random_light<cr><cr>
nnoremap <silent> <leader>a :ALEEnable<cr>
nnoremap <silent> <leader>h :ALEDetail<cr>
nnoremap <silent> <leader>ca :ALECodeAction<cr>
nnoremap <silent> <leader>qf :ALEPopulateQuickfix<cr>
nnoremap <silent> <C-k> :ALEHover<cr><C-w>k
nnoremap <silent> <leader>t :call ToggleNetrw()<cr>
nnoremap <silent> <leader>sh :call Shizukesa()<cr>
nnoremap <silent> <leader>m :make<cr><cr><cr>
nnoremap <silent> <leader>cp :cp<cr>
nnoremap <silent> <leader>cn :cn<cr>
nnoremap <silent> <leader>er :vsplit ~/.vim/README.md<cr>
nnoremap <silent> gl g_
nnoremap <silent> gh ^

" Insert 80 `-` characters to make a line like:
" --------------------------------------------
nnoremap <silent> <leader>- :normal 80i-<cr>

" GHC: Grep for the word under the cursor in compiler
nnoremap <silent> <leader>w :vimgrep /\<<c-r><c-w>\>/ compiler/** <bar> :copen <CR>

" DIFF: Diff the contents of registers @a@ and the lines currently selected
" Dropped in favor of the linediff.vim plugin
" vnoremap <silent> <leader>q y:vnew +put!a<cr>:new +put!<cr>:diffthis<cr><c-w><Down>:diffthis<cr>

" Wiki: Go to wiki index
nnoremap <silent> <leader>sw :tabe ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Romes\ Vault/ <CR>

" Set function key 24 escape sequence on this computer
" Use Ctrl+v+Fn24 to get control sequence for F24
nnoremap <silent> <ESC>[24;2~ :make<cr>


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

" For some annoying reason we need to refresh this, it seems to be forgotten
" somewhere, and it in $VIMRUNTIME/filetype.vim does not seem sufficient...
runtime! ftdetect/*.vim

" Configuration for tags
" Update the Haskell tags file when file is saved.
augroup tags
au BufWritePost *.hs            silent !fast-tags --no-module-tags %
au BufWritePost *.hsc           silent !fast-tags --no-module-tags %
augroup END

" Set runtimepath to include fzf, enabling the plugin Note that this path
" depends on where fzf is installed on the system and most likely is different
" from this.
set runtimepath+=/opt/homebrew/opt/fzf

" Map <leader>f to the fuzzy window finder command
" Actually amazing.
nnoremap <silent> <leader>f :FZF<cr>

" fzf.vim's RipGrep function to combine fzf+ripgrep in a nice search popup
" Mnemonic: g for grep
nnoremap <silent> <leader>g :Rg<cr>

" Use ripgrep by default for grepping
set grepprg=rg\ --vimgrep

" ======== VimWiki ============= {{{
let g:vimwiki_list = [{ 'path': '~/wiki',
                      \ 'path_html': '~/control/site/docs/wiki',
                      \ 'syntax': 'markdown', 'ext': '.md',
                      \ 'custom_wiki2html': '~/.vim/vimwiki2html.py' }]
                      " \ 'css_file': ...
let g:vimwiki_global_ext = 0

" Notes:
" Check all links are OK with :VimwikiCheckLinks
nnoremap <silent> <leader>wc :VimwikiCheckLinks<cr>

" }}}
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

let g:ale_virtualtext_cursor = 0                                | " Don't show error messages inline

let g:ale_sign_highlight_linenrs = 1                            | " Highlight line numbers in sign column, besides highlighting the sign

" let g:ale_completion_enabled = 1                              | " TODO: help ale-completion
" let g:ale_completion_autoimport = 1                           | " Automatically import external modules for completion

" Always highlight the SignLineNr as the sign
highlight link ALEErrorSignLineNr ALEErrorSign
highlight link ALEWarningSignLineNr ALEWarningSign

" Fix highlighting by linking to Coc in vim-github-colors
if g:colors_name == 'github'
    highlight link ALEError CocErrorHighlight
    highlight link ALEWarning CocWarningHighlight

    " Alternative
    highlight link ALEErrorSign CocErrorSign
    highlight link ALEWarningSign CocWarningSign
    highlight link ALESignColumnWithErrors ALEErrorSign

    " Alternative
    " highlight link ALEErrorSign ALEError
    " highlight link ALEWarningSign ALEWarning
    " highlight link ALESignColumnWithErrors ALEErrorSign
endif

" }}}
" ======== Polyglot ============ {{{

let g:polyglot_disabled = ['autoindent']                        | " Disable autoindent from vim-polyglot

" }}}
" ======== Unicode.vim ========= {{{
" Cheatsheet
" :UnicodeTable or :UnicodeSearch to find existing symbols
" :digraph to list all digraphs
" Motion `ga` to query the unicode decimal number for the symbol under the cursor
"
" Digraphs are actually a native feature: Press <Ctrl+k> and a combination of
" two letters to insert a digraph
"
" FA : ∀
" TE : ∃
" a* : α
" -T : ⊥
" (- : ∈
"
" Otherwise, use <Ctrl+x+g> to autocomplete a symbol from two letters
"
" For unicode symbols not associated with a digraph, we can insert them by
" name and with the unicode autocomplete command <Ctrl+x+z>
"
" elem : ∈
"
" Custom digraphs:

" Linear Logic Lollipop ⊸
digraph ll 8888
" Turnstile \vdash
digraph \|- 8870
" Set difference
digraph \\ 8726

" }}}

" }}}
" ======== Other =============== {{{

" Set syntax completion function for filetypes without a completion function
autocmd Filetype *
    \	if &omnifunc == "" |
    \		setlocal omnifunc=syntaxcomplete#Complete | " :help ft-syntax-omni
    \	endif

" Utilize pcalc inside of vim
command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'
command PCALC Silent pcalc

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

" foldenable
" vim: fdm=marker
