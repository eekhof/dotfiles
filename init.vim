:colorscheme evening
set spell spelllang=en_us " Enable spell checking per default, default to US English

:set number relativenumber          "display line number of current line and relative line number of all other lines
autocmd BufEnter * lcd %:p:h " Change current bash working directory to current file directory on opening file:
:set cursorline cursorcolumn "highlight current line and column
:set clipboard^=unnamed             "set default register to system clipboard (which is the middle click clipboard), which allows for pasting and copying into the system clipboard (Note the caret instead of plus, it is necessary here)
:set clipboard+=unnamedplus         "set the default register to the clipboard that is accessed by CTRL+C and CTRL+V, together with the line above it just takes the last one of the two that was used (I mostly use the latter) (Note the plus instead of caret, it is necessary here) Source for both: https://www.reddit.com/r/vim/comments/3ae4qf/psa_set_clipboardunnamed/
:set lazyredraw                     " Dont update screen during macro and script execution
:set ttyfast                        " Speed up scrolling in Vim
:set wildmode=list:longest          " Show all possible completions when pressing tab
:set ignorecase                     " Makes searches case insensitive
:set smartcase                      " Search case sensitive if it contains uppercase letter
" The following lines for tabs are from https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
:set shiftwidth=4 smarttab          " Set tab width to 4 spaces
:set softtabstop=4                  " width for tabs
:set expandtab                      " Use spaces instead of tabs
:set autoindent                     " Autoindent new lines

:filetype plugin indent on          " allow auto-indenting depending on file type TODO Is this really needed, or is it on by default?
:set tabstop=4                      " display width of tab
:set listchars=tab:――►,space:·      " Show tabs and spaces
:set list                           " Enable display of tabs and spaces characters
:syntax on                          " Syntax highlighting (Enables e. g. whitespace marker coloring)
:hi Whitespace ctermbg=NONE ctermfg=DarkGray        " Disable background highlighting of tabs and spaces
:set noswapfile                     " Disable creation of swap files (See https://stackoverflow.com/questions/821902/disabling-swap-files-creation-in-vim)

:set splitright splitbelow          " Create split windows below and to the right instead of above and left
set fillchars+=vert:\               " Replace tile border with space
:hi VertSplit ctermfg=bg ctermbg=bg guifg=bg guibg=bg " Recolor tile border frame colors with background and foreground colors of current theme, so as to make it invisible
:set fillchars+=eob:\               " Replace end of buffer tildes with space to hide them

:set formatoptions-=cro " Prevent comments from wrapping, and being continued after pressing o on a comment line

" Turn off specific things for latex files, else vim gets slow (Source: https://stackoverflow.com/questions/8300982/vim-running-slow-with-latex-files):
au BufNewFile,BufRead *.tex
    \ set nocursorline nocursorcolumn |
    \ let g:loaded_matchparen=1 |

" Mappings -----------------------------
" Map leader key to space:
let mapleader = "\<Space>"
let maplocalleader = "\<Space>" " Make local leader key same as leader key, required by vimtex, see https://stackoverflow.com/questions/26837425/vim-how-to-use-the-control-key-as-my-local-leader
":inoremap jk <Esc>                 " Map jk to escape from insert mode to prevent reaching for escape - If needing to type literal jk, one has to wait one to two seconds between presses, see https://vim.fandom.com/wiki/Avoid_the_escape_key " TODO SHould betterescape really be used instead of this, or is it bloat?
":inoremap kj <Esc>                 " Map jk to escape from insert mode to prevent reaching for escape - If needing to type literal jk, one has to wait one to two seconds between presses, see https://vim.fandom.com/wiki/Avoid_the_escape_key
" Map capital S to replace all:
nnoremap S :%s//g<Left><Left>
" Insert empty line above and below current line:
nnoremap oo o<Esc>k
nnoremap OO O<Esc>

" Delete without yanking
noremap d "_d
noremap dd "_dd
noremap D "_D
" Change without yanking
noremap c "_c
noremap cc "_cc
noremap C "_C
" Delete single characters without yanking
noremap x "_x
noremap X "_X
" Delete with yanking = Cut (Is equivalent to default behaviour of d and D)
noremap <Leader>d d
noremap <Leader>dd dd
noremap <Leader>D D

" Make change whole line ("cc") start at first non-blank character, so that it does not delete the indentation:
nnoremap cc _C
" Maybe make CC use the old behavior of cc, so that it deletes the indentation?

" Map for easier window tile navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Map for easier window tile resizing
nnoremap <C-Up> <C-W>+
nnoremap <C-Down> <C-W>-
nnoremap <C-Left> <C-W><
nnoremap <C-Right> <C-W>>
nnoremap <C-M> <C-W>=

" Map to switch jumping to marks accent aigu and apostrophe, because accent aigu does not work when dead keys are enabled, and jumping to line and column is more important:
nnoremap ' `
nnoremap ` '
" Map to make Return-key usable in Coc-Menu:
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
" Prevent cursor from shifting to left after enter-leaving the insert mode:
let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
" Map File explorer to CTRL+n
nnoremap <C-n> :Sexplore! <CR>

" Command to correct last/next error to first recommended spelling:
noremap <Leader>z [s1z=gi<ESC>l
noremap <Leader>Z ]s1z=gi<ESC>l

" Map capital U to redo instead of ctrl+r and restore state of last changed line to leader+capital U instead of capital U:
nnoremap U <C-R>
nnoremap <Leader>U U

" Mapping to display register list and paste content of register that is selected by "number/letter" + "enter" at the bottom prompt in the split window that shows the registers: (Source: https://vi.stackexchange.com/questions/8467/how-can-i-easily-list-the-content-of-the-registers-before-pasting/8468#8468)
nnoremap <Leader>p :reg <bar> exec 'normal! "'.input('>').'p'<CR>

" Brackets and Braces completion (Source: https://vim.fandom.com/wiki/Automatically_append_closing_characters) TODO: THIS CAUSES MUCH LAG WHEN TYPING IN FRONT OF CLOSING BRACKET o. ä.
" Curly Brackets:
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap        {  {}<Left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
" Parentheses:
inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()
inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
" Square Brackets:
inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []
inoremap        [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
" Double Quotes (Same character comletions are a little different in the last line, see source):
inoremap "      ""<Left>
inoremap "<CR>  "<CR>"<Esc>O
inoremap ""     ""
inoremap        "  ""<Left>
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
" Single Quotes:
inoremap '      ''<Left>
inoremap '<CR>  '<CR>'<Esc>O
inoremap ''     ''
inoremap        '  ''<Left>
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
" Dollar Sign:
inoremap $      $$<Left>
inoremap $<CR>  $<CR>$<Esc>O
inoremap $$     $$
inoremap        $  $$<Left>
inoremap <expr> $  strpart(getline('.'), col('.')-1, 1) == "$" ? "\<Right>" : "$$\<Left>"


" Make each character in list below work as text object for latex selection, see https://vi.stackexchange.com/questions/12146/refer-to-text-between-arbitrary-delimiting-characters
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '$', '=', "<Space>", ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" Commands -----------------------------
" Wipe all registers (Source: https://stackoverflow.com/questions/19430200/how-to-clear-vim-registers-effectively/41003241#41003241)
command! WipeRegs for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor | :wsh!


" Plugins -----------------------------

" VIM-PLUG BOOTSTRAP (Source https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation-of-missing-plugins and for path https://www.youtube.com/watch?v=69tzu7YVlx4)
" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


" Plugins (Source https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation-of-missing-plugins (Pay attention to wrong quotation marks due to copy-pasting) and for path https://www.youtube.com/watch?v=69tzu7YVlx4)
call plug#begin("~/.config/nvim/autoload/plugged")
  " Plugin Section
  Plug 'github/copilot.vim'
  Plug 'jdhao/better-escape.vim' "TODO MAYBE use https://github.com/max397574/better-escape.nvim instead, codebase is smaller, is newer, might be faster, but is only in lua, thus not compat with vim, but the latter doesnt matter because copilot seems to be only available for nvim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-signify'
  Plug 'lervag/vimtex'
  " TODO Do this only if markdown file is edited, since this throws an error which delays vim startup
  if &filetype ==# 'markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' }
    " For markdown-preview plugin install to work:
    :call mkdp#util#install()
  endif
call plug#end()


" Options for plugins
" COPILOT
" COPILOT
" vim.g.copilot_filetypes = { markdown = true } -- Enable copilot for markdown files
" Enable partial suggestions, see https://www.reddit.com/r/neovim/comments/z4stsy/how_to_accept_half_or_word_by_word_suggestion_by/ -- TODO: Does behave weirdly when accepting multiline suggestions over the first line, or deletes visible rendering of suggestion when accepting too fast
" local function SuggestOneWord()
"   local suggestion = vim.fn['copilot#Accept']("")
"   local bar = vim.fn['copilot#TextQueuedForInsertion']()
"   return vim.fn.split(bar,  [[[ .]\zs]])[1]
" end
" vim.keymap.set('i', '<C-l>', SuggestOneWord, {expr = true, remap = false})--TODO: For more sensible mappings of copilot commands see https://bignerdranch.com/blog/github-copilot-using-the-plugin-for-neovim/
let g:copilot_filetypes = {'markdown': v:true,} "enable copilot for markdown files
" TODO: Eventually add accept partial suggestion hotkey, see e. g.: https://github.com/orgs/community/discussions/12426#discussioncomment-3102062
" BETTER ESCAPE
let g:better_escape_shortcut = ['jk'] " Map jk to escape from insert mode to prevent reaching for escape - If needing to type literal jk, one has to wait one to two seconds between presses, see https://vim.fandom.com/wiki/Avoid_the_escape_key
let g:better_escape_interval = 300
" Start file explorer, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | Explore | endif
" SIGNIFY
set updatetime=100 " Time until gutter symbols get displayed
" COC
" Install pyright for python if not already installed:
if empty(glob('~/.config/coc/extensions/node_modules/coc-pyright'))
  autocmd VimEnter * CocInstall coc-pyright
endif
" Install coc-html for html-support if not already installed:
if empty(glob('~/.config/coc/extensions/node_modules/coc-html'))
  autocmd VimEnter * CocInstall coc-html
endif
" Install coc-vimtex for vimtex-support if not already installed:
if empty(glob('~/.config/coc/extensions/node_modules/coc-vimtex'))
  autocmd VimEnter * CocInstall coc-vimtex
endif
" Install coc-sh for shell-support if not already installed:
if empty(glob('~/.config/coc/extensions/node_modules/coc-sh'))
  autocmd VimEnter * CocInstall coc-sh
endif
" VIMTEX
let g:vimtex_view_method = 'zathura' " Use zathura as pdf viewer
" Exit vim if quickfix window is last window on screen (Source https://vim.fandom.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last):
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit
    endif
  endif
endfunction
" VIMTEX-LIVE-PREVIEW
let g:livepreview_previewer = 'zathura' " Use zathura as pdf viewer
" TODO: Let Vimtex syntax highliting recognize some greek characters as normal characters, so that they can be used in math mode, with e. g. the following commands (Source: https://vi.stackexchange.com/questions/19040/add-keywords-to-a-highlight-group/19043#19043): " TODO Probably gets overwritten by vimtex plugin loading i somethign afterwards, even though earlier in the file
":syntax keyword LatexGreekLetters α β γ δ ε ζ η θ ι κ λ μ ν ξ π ρ σ τ υ φ χ ψ ω Γ Δ Θ Λ Ν Ρ Σ Υ Φ Ψ Ω
":highlight def link LatexGreekLetters Special
" TODO: Adjust group in the line above, for groups see http://www.drchip.org/astronaut/vim/syntax/tex.vim.gz
" MARKDOWN-PREVIEW
let g:mkdp_auto_start = 1 " Start preview automatically when opening markdown file
let g:mkdp_port = '3415' " Set port for preview, otherwise it would be chosen at random, which could potentially conflict
let g:mkdp_theme = 'dark'


" Templates -----------------------------
augroup templates
    " LaTeX
    autocmd BufNewFile *.tex 0r !echo -e '\documentclass{article}\n\\usepackage{eekhof}\n\n\\title{TITLE}\n\\begin{document}\n\nCONTENT\n\n\\end{document}'
    " Delete trailing newline, then go to title placeholder and delete it
    autocmd BufNewFile *.tex execute "normal Gdd/TITLE\<CR>dwl"

    " Markdown
    autocmd BufNewFile *.md 0r !echo '\# TITLE'
    " Go to title placeholder and delete it
    autocmd BufNewFile *.md execute "normal Gdd/TITLE\<CR>cw\ "

    " Shell script
    autocmd BufNewFile *.sh 0r !echo -e '\#\!/bin/sh\n'
    " Go to bottom of file
    " autocmd BufNewFile *.md execute "normal G"

    " Start in insert mode for any new file:
    autocmd BufNewFile * star
augroup END

" Filetype recognition -----------------------------
" Set the filetype groff based on the file's extension, overriding any 'ff' that has already been set (Source: https://stackoverflow.com/questions/11666170/persistent-set-syntax-for-a-given-filetype/28117335#28117335)
au BufRead,BufNewFile *.ff set filetype=groff


" Statusline etc. -----------------------------
:set statusline=%f    " File name without path
:set statusline+=%=    " Switch to the right side
:set statusline+=\ CWD:\ %-1{getcwd()}\ \ \ \ \ \ \      " Current working directory
:set statusline+=Ln:\ %3l/%L\     " Lines out of total lines
:set statusline+=\ Col:\ %-3c\    " Current column
":set statusline+=\ (%-3p%%)\    " Percentage through file

:set title    " Show title in window
:set titlestring=NeoVim:\ %F\ %a%r%m titlelen=70    " Title of the window

" Insert input function (Source: https://stackoverflow.com/questions/51575227/enter-insert-mode-between-two-tags-after-command-in-vim/51579524#51579524):
function InsertInput(description)
    let currline = line(".")
    call inputsave()
    let input_content = input(a:description . ": ")
    call inputrestore()
    exe "normal! a" . input_content . "\<Esc>"
endfunction

" Snippets: (For help and inspiration see "Snippet" part of https://vonheikemen.github.io/devlog/tools/using-vim-abbreviations/)
:autocmd FileType tex          iabbrev fr \frac{ENUMERATOR}{DENOMINATOR}<Esc>?ENUMERATOR<CR>dwh:call InsertInput("Enumerator")<CR><Esc>?DENOMINATOR<CR>dwh:call InsertInput("Denominator")<CR>a<right>
:autocmd FileType tex          iabbrev sm \sum\limits_{SUBSCRIPT}^{SUPERSCRIPT}<Esc>?SUBSCRIPT<CR>dwh:call InsertInput("Subscript")<CR><Esc>?SUPERSCRIPT<CR>dwh:call InsertInput("Superscript")<CR>a<right>
:autocmd FileType tex          iabbrev nt \int\limits_{SUBSCRIPT}^{SUPERSCRIPT}<Esc>?SUBSCRIPT<CR>dwh:call InsertInput("Subscript")<CR><Esc>?SUPERSCRIPT<CR>dwh:call InsertInput("Superscript")<CR>a<right>
:autocmd FileType tex          iabbrev lm       \lim\limits_{SUBSCRIPT}<Esc>?SUBSCRIPT<CR>dwh:call InsertInput("Subscript")<CR>a<right>
:autocmd FileType tex          iabbrev inc       \incfig{FILENAME}{CAPTION}<Esc>?FILENAME<CR>dwh:call InsertInput("Filename (Without ending)/Reference key")<CR><Esc>?CAPTION<CR>dwh:call InsertInput("Caption")<CR>a<right>
:autocmd FileType tex          iabbrev lr        \l( \r)<left><left><left><left>
:autocmd FileType tex          iabbrev ali       \begin{align}<CR><Space><CR>\end{align}<up>
:autocmd FileType tex          iabbrev alin       \begin{align*}<CR><Space><CR>\end{align*}<up>
:autocmd FileType tex          iabbrev eq       \begin{equation}<CR><Space><CR>\end{equation}<up>
:autocmd FileType tex          iabbrev eqn      \begin{equation*}<CR><Space><CR>\end{equation*}<up>
:autocmd FileType tex          iabbrev sq      \sqrt{}<left>
:autocmd FileType tex          iabbrev lra      \leftrightarrow{}
:autocmd FileType tex          iabbrev Lra      \Leftrightarrow{}
:autocmd FileType tex          iabbrev si \SI{VALUE}{UNIT}<Esc>?VALUE<CR>dwh:call InsertInput("Value")<CR><Esc>?UNIT<CR>dwh:call InsertInput("Unit")<CR>a<right>
" TODO: COC messes with align and equation environments, fix this by disabling spacebar for coc completion

" TODOs -----------------------------
" TODO: Fugitive commands all throw errors (e. g. Gdiff and Git)
" TODO: Pyright does work, but pyright- command line commands do not work yet
" TODO: Focus on Vim after inverse search (Solution from source https://www.ejmastnak.com/tutorials/vim-latex/pdf-reader/#refocus-gvim did not work)
" TODO: 'xuhdev/vim-latex-live-preview' causes error 'error: python required', fix this
" TODO: Set up zathura to start with frame fit to width
" TODO: Set up VimTex to start in splitscreen with zathura on the right
" TODO: Set up Jupyter Notebook support
" TODO: Do HTML-Commands work yet?
" TODO: Set up CoC-Vimtex to provide brackets after commands
" TODO: Set up CoC to move on one column on typing out closing brackets
" TODO: Correct markdown-preview error (See above)
" TODO: Add color to statusline
" TODO: Add error highlighting in LaTeX
" TODO: Add jump to error via clicking link in quickfix for LaTeX
" TODO: MAYBE use https://github.com/max397574/better-escape.nvim instead, codebase is smaller, is newer, might be faster, but is only in lua, thus not compat with vim, but the latter doesnt matter because copilot seems to be only available for nvim
" TODO: Only load vimtex when tex- or bibfile is edited, edit markdown autostart to make use of the check above instead
"TODO: THIS CAUSES MUCH LAG WHEN TYPING IN FRONT OF CLOSING BRACKET o. ä.
" TODO: Sometimes <NUMBER>V does not work right for multiple line selection
" TODO: When putting a closing bracket behind an indented line, the line sometimes gets unindented
" TODO: Insert functionality that when using e. g. "da(" while not inside brackets, it just applies the operation to the next bracket
" TODO: Make f F t and T and also ;, work on multiple lines (Possible Source: https://stackoverflow.com/questions/3925230/using-vims-f-command-over-multiple-lines/10564049#10564049 but this causes repetition like 3fx to not work anymore)
" TODO: For copilot eventually add accept partial suggestion hotkey, see e. g.: https://github.com/orgs/community/discussions/12426#discussioncomment-3102062
" TODO: Let Vimtex syntax highliting recognize some greek characters as normal characters

" Uninstall -----------------------------
" To uninstall this script and all changes made by it, delete '~/.config/nvim' and '~/.config/coc'
