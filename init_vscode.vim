" Options -----------------------------
:set clipboard^=unnamed             "set default register to system clipboard (which is the middle click clipboard), which allows for pasting and copying into the system clipboard (Note the caret instead of plus, it is necessary here)
:set clipboard+=unnamedplus         "set the default register to the clipboard that is accessed by CTRL+C and CTRL+V, together with the line above it just takes the last one of the two that was used (I mostly use the latter) (Note the plus instead of caret, it is necessary here) Source for both: https://www.reddit.com/r/vim/comments/3ae4qf/psa_set_clipboardunnamed/
:set lazyredraw                     " Dont update screen during macro and script execution
:set ttyfast                        " Speed up scrolling in Vim
:set ignorecase                     " Makes searches case insensitive
:set smartcase                      " Search case sensitive if it contains uppercase letter
:set formatoptions-=cro " Prevent comments from wrapping, and being continued after pressing o on a comment line
:set noswapfile                     " Disable creation of swap files (See https://stackoverflow.com/questions/821902/disabling-swap-files-creation-in-vim)


" Mappings -----------------------------
(For key combinations see https://keycombiner.com/collections/vim/)
" Map leader key to space:
let mapleader = "\<Space>"
" Map capital S to replace all:
"nnoremap S :%s//g<Left><Left> TODO Replacement does not work when inserted with this mapping
" Insert empty line above and below current line:
nnoremap oo o<Esc>k
nnoremap OO O<Esc>j

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

" Map to switch jumping to marks accent aigu and apostrophe, because accent aigu does not work when dead keys are enabled, and jumping to line and column is more important:
nnoremap ' `
nnoremap ` ' 

" Switch second-to-last word with current word, second command is vice versa (e. g. for switching or or and statements; needs to be this complicated to be robust against line endings; will overwrite last numbered register with second word)
noremap <Leader>s "9daww"9P"9dawbb"9Pa <ESC>b"_X
noremap <Leader>S bb"9daww"9P"9dawbb"9Pa <ESC>b"_Xww

" Command to correct last/next error to first recommended spelling: " TODO DOES NOT YET WORK WITH VS-CODE
noremap <Leader>z [s1z=gi<ESC>l
noremap <Leader>Z ]s1z=gi<ESC>l

" Map capital U to redo instead of ctrl+r and restore state of last changed line to leader+capital U instead of capital U:
nnoremap U <C-R>
nnoremap <Leader>U U

" Mapping to display register list and paste content of register that is selected by "number/letter" + "enter" at the bottom prompt in the split window that shows the registers: (Source: https://vi.stackexchange.com/questions/8467/how-can-i-easily-list-the-content-of-the-registers-before-pasting/8468#8468)
nnoremap <Leader>p :reg <bar> exec 'normal! "'.input('>').'p'<CR>

" Commands -----------------------------
" Wipe all registers (Source: https://stackoverflow.com/questions/19430200/how-to-clear-vim-registers-effectively/41003241#41003241)
command! WipeRegs for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor | :wsh!


" Make each character in list below work as text object for latex selection, see https://vi.stackexchange.com/questions/12146/refer-to-text-between-arbitrary-delimiting-characters
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '$', '=', "<Space>", ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor
" TODOs -----------------------------
" TODO: GCC commenting plugin would be nice to have
" TODO: ii to leave insert mode does not work yet
" TODO: Add templates for new files as snippets, as seen in init.vim
" TODO: Replace all mapping does not work when pressing enter
" TODO: Latex Dollarsign selection does not work yet
" TODO: Use Plugins: vim-peakaboo to show contents of resiters, vim sneak to move faster, GCC-commenting to comment out lines
" TODO: Add shortcuts for latex mathmode commands, e. g. in normal mode activate latex insertion with e. g. "ö" key, which when followed by e. g. "f" will insert "\frac{}{}" and place the cursor in the first braces (in best case with jump markers between next braces and after the command). Also include shortcuts for other mathmode commands, e. g. "s" for "\sqrt{}", "b" for "\bracfrac{}{}", rightarrow-key for "\rightarrow", shift+rightarrow-key for "\Rightarrow" or "\follows", "1" "2" "3" etc. for sections and subsections, "i" for itemize environment, "u" (-> unit) for "\SI{}{}", "*" for "\cdot", etc.
" TODO: Deadgreek-small-theta does not work (on j key), presumably because jj is mapped to listen to for escape for normal mode, maybe change to jk, or double-capslock or double oe-umlaut (Same problem for k -> kappa)
" TODO: Vim starts in insert mode, start in normal mode instead
" TODO: Send deletes with x and X to the blackhole register too, so they do not spam the clipboard, or hardcode small letter theta in keybinding config to Rightctrl+j
" TODO: Use JupyterAscending for Jupyter integration (https://github.com/untitled-ai/jupyter_ascending and https://alpha2phi.medium.com/jupyter-notebook-vim-neovim-c2d67d56d563) OR JupyText (https://github.com/mwouts/jupytext)
" TODO: For showind better git diffs, use vimdiff and set it as default diff tool for git, see https://medium.com/usevim/git-and-vimdiff-a762d72ced86
" TODO: z and Z for correcting errors does not yet work with vs-code

" Uninstall -----------------------------
" To uninstall this script and all changes made by it, delete '~/.config/nvim'
