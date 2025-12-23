-- For rewriting init.vim in lua, see https://www.notonlycode.org/neovim-lua-config/ and https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- FOR INSTALL: Run the console commands, and run github authentification for copilot
-- sudo pacman -S git zathura zathura-pdf-mupdf pyright bash-language-server texlab ripgrep fzy gitui tree-sitter-cli
-- pip install nvr # For neovim remote opening into same window, as well as editor commands called by nvim terminal opening in parent neovim instance
-- TODO: Markdown preview does not work yet (It does work on a fresh linux installation)
-- TODO: When having initialized a new git repo in a folder in which the main latex document lies, the GIT.gitignore does not yet get generated, as per the eekhof-latex-package, when compiled with vimtex
-- TODO: A weird bug with nvim-cmp occured after typing a linebreak, which displayed some red error message in the console, inserted the last completion that was made at that wrong spot, and crashed the completion so that no other completions were suggested in that buffer, until it was restarted
-- TODO: Jumping from PDF in Zathura to latex source code with ctrl+click does not yet work, for start of solution see maybe https://www.ejmastnak.com/tutorials/vim-latex/pdf-reader/
-- TODO: Die Completionvorschläge brechen ab, wenn im vorgeschlagenen Wort ein Umlaut ist (Zumindest bei reinen Textvorschlägen)
-- TODO: Ersetze completion plugin mit https://vim.fandom.com/wiki/Improve_completion_popup_menu und https://georgebrock.github.io/talks/vim-completion/
-- TODO: Ersetze pyright mit basedpyright, ist besser, community driven und braucht kein node-js sondern nur pip zur installation
-- TODO: Ersetze surrounding pair defs mit mini.pairs, und surrounds mit mini.surround
-- TODO: Nutze die Treesitter-Plugins https://github.com/windwp/nvim-ts-autotag , https://github.com/nvim-treesitter/nvim-treesitter-context , https://github.com/nvim-treesitter/nvim-treesitter-textobjects , https://github.com/nvim-treesitter/nvim-treesitter-refactor
-- TODO: Implementiere true-false-switch mit CTRL-x/a , siehe z.b. https://vi.stackexchange.com/questions/5213/swap-values-true-and-false-via-ctrla-ctrlx
-- TODO: Fuer Jupyter-Support nutze Molten.Nvim, https://github.com/benlubas/molten-nvim , ist ein successor von https://github.com/dccsillag/magma-nvim . Eigentlich wäre https://www.vim.org/scripts/script.php?script_id=6064 also https://github.com/PhilGrunewald/vim-py-kid cooler, aber funktioniert nicht
-- TODO: Remap Ctrl+6 so that it goes to last existing buffer instead of last buffer, otherwise going back a buffer breaks when using the vim file browser
-- TODO: Use yazi as file browser
-- TODO: Make F5 execution only execute the program if compilation was successful DONE?
-- TODO: TODO: Add a autocmd BufWritePost that will copy the file over on save with w | !cp % .REMOTE_DIR/% if a softlink .REMOTE_DIR is present in the current directory

-- Colorscheme -----------------------------
-- vim.cmd.colorscheme('evening')
-- vim.api.nvim_set_hl(0, "Normal", { ctermfg=231, ctermbg=000, cterm=NONE }) -- Prevent vim from changing background color, see https://www.reddit.com/r/vim/comments/5u5ujc/suggestions_on_black_dark_colorscheme/
-- vim.api.nvim_set_hl(0, "CursorColumn", { ctermfg=NONE, ctermbg=237, cterm=NONE }) -- Change bg to darker grey to match true black
-- vim.api.nvim_set_hl(0, "CursorLine", { ctermfg=NONE, ctermbg=237, cterm=NONE }) -- Change bg to darker grey to match true black
-- vim.api.nvim_set_hl(0, "CursorLineNr", { ctermfg=226, ctermbg=237, cterm=NONE }) -- Change bg to darker grey to match true black
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { ctermfg=153, ctermbg=000, cterm=NONE }) -- Change bg to true black
-- vim.api.nvim_set_hl(0, "StatusLine", { ctermfg=000, ctermbg=231, cterm=bold }) -- Change fg to true black
-- vim.api.nvim_set_hl(0, "StatusLineNC", { ctermfg=000, ctermbg=252, cterm=NONE }) -- Change fg to true black
-- vim.api.nvim_set_hl(0, "TabLineSel", { ctermfg=000, ctermbg=231, cterm=bold }) -- Change fg to true black
-- vim.api.nvim_set_hl(0, "TabLine", { ctermfg=000, ctermbg=252, cterm=NONE }) -- Change fg to true black
-- vim.api.nvim_set_hl(0, "NonText", { ctermfg=153, ctermbg=000, cterm=NONE }) -- Change bg to true black
-- vim.api.nvim_set_hl(0, "Ignore", { ctermfg=000, ctermbg=NONE, cterm=NONE }) -- Change fg to true black
-- vim.api.nvim_set_hl(0, "FloatBorder", { ctermfg=231, ctermbg=000, cterm=NONE }) -- Change window border color to black and white, this should be default, but somehow doesn't work when calling nvim_open_win

-- Transparency:
vim.api.nvim_set_hl(0, "Normal", { ctermfg=231, guibd=NONE, ctermbg=NONE, cterm=NONE }) -- For transparency of background
vim.api.nvim_set_hl(0, "NonText", { ctermfg=153, ctermbg=NONE, cterm=NONE }) -- For transparency of background
vim.api.nvim_set_hl(0, "EndOfBuffer", { ctermfg=153, ctermbg=NONE, cterm=NONE }) -- For transparency of background

-- General options -----------------------------
vim.api.nvim_create_autocmd('FileType', { -- Enable spellchecking but only for text files
    pattern = { 'tex', 'bib', 'typ', 'text', 'markdown'},
    callback = function()
        vim.o.spell = true                              -- Enable spell checking per default
        vim.o.spelllang = 'en_us'                       -- Default spell checking language to US English
        vim.o.wrap = true                               -- Enable line wrapping
    end,
    group = spelling
})

vim.o.number = true                             -- Display line number of current line
vim.o.relativenumber = true                     -- Display relative line number of all other lines
vim.o.signcolumn = 'yes'                        -- Always show sign column, so that line numbers do not jump around when language server blends in warnings and errors when switching out of insert mode
vim.o.cursorline = true                         -- Highlight current line
vim.o.cursorcolumn = true                       -- Highlight current column
vim.o.whichwrap = 'b,s,h,l,<,>,[,]'             -- Allow wrapping around lines

vim.o.undofile = true                           -- Enable persistent undo

vim.o.clipboard = 'unnamed,unnamedplus'         -- Set the default register to the clipboard that is accessed by CTRL+C and CTRL+V, together with the line above it just takes the last one of the two that was used (I mostly use the latter) (Note the plus instead of caret, it is necessary here) Source for both: https://www.reddit.com/r/vim/comments/3ae4qf/psa_set_clipboardunnamed/
vim.api.nvim_create_autocmd('TextYankPost', { -- Highlight yanked text, useful if yanking outside of visual mode, source: https://github.com/VonHeikemen/nvim-starter/blob/00-minimal/init.lua
    group = grp,
    desc = 'Highlight on yank',
    callback = function()
        vim.highlight.on_yank({higroup = 'Visual', timeout = 300})
    end,
})

-- Remember folded text:
-- vim.api.nvim_create_autocmd({"BufWinLeave"}, {
--   pattern = {"*.*"},
--   desc = "save view (folds), when closing file",
--   command = "mkview",
-- })
-- vim.api.nvim_create_autocmd({"BufWinEnter"}, {
--   pattern = {"*.*"},
--   desc = "load view (folds), when opening file",
--   command = "silent! loadview"
-- })

-- Set the titlestring, which is displayed e.g. in the window titles in I3:
vim.o.title = true
local augroup = vim.api.nvim_create_augroup("SetTitleString", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = augroup,
  callback = function()
    vim.opt.titlestring = "%t%( %M%)%( (%{expand('%:~:h')})%)%a - Nvim"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
  end,
  desc = "Set indentation for Typst files"
})

vim.o.autochdir = true                          -- Change current bash working directory to current file directory on opening file (may not work as well as the ones above with the plugin, see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file#Automatically_change_the_current_directory)
vim.o.lazyredraw = true                         -- Dont update screen during macro and script execution to save resources
vim.o.ttyfast = true                            -- Speed up scrolling in Vim
vim.o.scrolloff = 5                             -- Keep 5 lines above and below cursor when scrolling
vim.o.sidescrolloff = 20                        -- Keep 30 characters left and right of cursor when scrolling
vim.o.ignorecase = true                         -- Makes searches case insensitive
vim.o.smartcase = true                          -- Search case sensitive if it contains uppercase letter
-- The following lines for tabs are from https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
vim.o.shiftwidth = 4                            -- Set tab width to 4 spaces
vim.o.smarttab = true                           -- Enable smarttabs
vim.o.softtabstop = 4                           -- Set width for tabs
vim.o.expandtab = true                          -- Use spaces instead of tabs
vim.o.autoindent = true                         -- Autoindent new lines
vim.o.tabstop = 4                               -- Set display tab width to 4 spaces, otherwise arrows as tab symbols get elongated
vim.o.list = true                               -- Configure this for display of tabs and spaces characters, see comment on Source: https://vi.stackexchange.com/questions/31811/neovim-lua-config-how-to-append-to-listchars/37971#37971
vim.o.listchars = 'tab:――►,space:·'             -- Show tabs and spaces
vim.o.wrap = true                              -- Disable line wrapping
vim.o.showbreak = '│'                           -- Show this character when a line is wrapped
vim.o.linebreak = true                          -- Break only at this character
vim.o.breakindent = true                        -- Break only at this character
vim.api.nvim_set_hl(0, 'NonText', {ctermbg='NONE', ctermfg='DarkGray'}) -- Disable background highlighting of linebreak/linewrap characters (Also affects other non-text characters)
vim.o.showmatch = true--TODO: Is this done later on again, making this redundant?                          -- Show matching brackets
vim.o.syntax = 'on'                             -- Syntax highlighting (Enables e. g. whitespace marker coloring)
vim.api.nvim_set_hl(0, 'Whitespace', {ctermbg='NONE', ctermfg='DarkGray'}) -- Disable background highlighting of tabs and spaces
vim.o.swapfile = false                          -- Disable creation of swap files (See https://stackoverflow.com/questions/821902/disabling-swap-files-creation-in-vim)

vim.o.splitright = true                         -- Create split windows below and to the right instead of above and left
vim.o.splitbelow = true                         -- Create split windows below and to the right instead of above and left
vim.o.fillchars = 'vert: '                     -- Replace tile border with space
vim.api.nvim_set_hl(0, 'VertSplit', {ctermbg='Gray', ctermfg='Gray'})--TODO: THIS DOES NOT WORK PROPERLY -- Recolor tile border frame colors with background and foreground colors of current theme, so as to make it invisible
-- :hi VertSplit ctermfg=bg ctermbg=bg guifg=bg guibg=bg " Recolor tile border frame colors with background and foreground colors of current theme, so as to make it invisible
vim.o.fillchars = 'eob:¬'                       -- Replace end of buffer tildes with not symbol, can be replaced with space to hide them
-- TODO: This does not seem to change anything, at least not when going into next line from a comment: vim.o.formatoptions = vim.o.formatoptions:gsub("[cro]", "")-- Prevent comments from wrapping, and being continued after pressing o on a comment line (String manipulation removes options "c", "r" and "o")

-- TODO: Is this neccessary, or does lua make it fast enough? -- Turn off specific things for latex files, else vim gets slow (Source: https://stackoverflow.com/questions/8300982/vim-running-slow-with-latex-files):
-- au BufNewFile,BufRead *.tex
--     \ set nocursorline nocursorcolumn |
--     \ let g:loaded_matchparen=1 |

-- Start file explorer, unless a file or session is specified, eg. vim -S session_file.vim.
if next(vim.fn.argv()) == nil then
    vim.cmd.normal('Explore')
end

-- Mappings -----------------------------
-- Aliases for mappings, see Source (by default, they are all nonrecursive):
function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
function nmap(shortcut, command)
    map('n', shortcut, command)
end
function imap(shortcut, command)
    map('i', shortcut, command)
end
function vmap(shortcut, command)
    map('v', shortcut, command)
end
function tmap(shortcut, command)
    map('t', shortcut, command)
end
function xmap(shortcut, command) -- This is very niche, it applies a mapping to visual mode only, while vmap applies to visual AND select mode, see :h mapmode-x or :h map-modes
    map('x', shortcut, command)
end
function smap(shortcut, command) -- This is very niche, it applies a mapping to select mode only, while vmap applies to visual AND select mode, see :h mapmode-s or :h map-modes
    map('s', shortcut, command)
end
function omap(shortcut, command) -- This is very niche, it applies a mapping to select mode only, while vmap applies to visual AND select mode, see :h mapmode-s or :h map-modes
    map('o', shortcut, command)
end

-- -------------------------- gallium recommendations
-- In qute, "a" and "e" are not bound, making remapping to gallium very easy, since "h" just stays where it is (shifted one to right from querty). So I just have to remap the movements, and their capitals, and i for inserting into field to k (see below)
-- hjkl -> haei
-- aei -> ljk : a zu l weil leicht erreichbar um in insert mode zu wechseln, e zu j weil e nicht so oft gebraucht wird, und j ist schwer zu erreichen, i zu k weil i für insert mode und leicht zu erreichen, und auch in vim wichtig für diw zum Beispiel
-- -------------------------- older colemak settings
-- Get all the default mappings from view-source:https://vim.rtorr.com/
-- === H does not need to be remapped, because h is an graphite homerow
-- === J
nmap('a', 'j')
vmap('a', 'j')
nmap('ga', 'gj') -- move to next line
vmap('ga', 'gj') -- move to next line
nmap('A', 'J') -- join lines
vmap('A', 'J') -- join lines
imap('<C-a>', '<C-j>') -- add linebreak at current position

nmap('l', 'a') -- Append
vmap('l', 'a') -- Append
nmap('gl', 'ga') -- Display hexal/octal of number under cursor
vmap('gl', 'ga') -- Display hexal/octal of number under cursor
nmap('L', 'A') -- Append at end of line
vmap('L', 'A') -- Append at end of line
-- imap('<C-L>', '<C-A>') -- This is not needed because by default C-A does nothing in vim and this would require remapping the C-L escape sequence

-- === K

-- vim.keymap.del('v', 'i') -- Remove waiting for text object after pressing i in visual mode -- TODO somehow like this i should be able to eliminate lag
nmap('e', 'k')
vmap('e', 'k') -- TODO: This works, but in visual mode i first waits for another character because of text objects, e.g. "i(", this leads to delay and accidental overpresses of i. For possible solution see https://www.reddit.com/r/vim/comments/be2sik/remap_textobject_commands/
nmap('ge', 'gk') -- move to previous line
vmap('ge', 'gk') -- move to previous line
nmap('E', 'K') -- open manpage for word under cursor

nmap('j', 'e')
vmap('j', 'e')
nmap('gj', 'ge')
vmap('gj', 'ge')
nmap('J', 'E')

-- === L
nmap('i', 'l')
vmap('i', 'l')
nmap('I', 'L') -- move to bottom of screen
vmap('I', 'L') -- move to bottom of screen
omap('i', 'l') -- For text object to the right

nmap('j', 'i')
nmap('J', 'I') -- insert at beginning of line
vmap('j', 'i')
vmap('J', 'I') -- insert at beginning of line
nmap('<C-j>', '<C-i>') -- ATTENTION: This cannot be mapped, mapping Ctrl+i will break the tab key, since Ctrl+i is its terminal composed character sequence. See https://unix.stackexchange.com/questions/563469/conflict-ctrl-i-with-tab-in-normal-mode and https://vi.stackexchange.com/questions/25473/tab-does-not-work-with-vim-for-me -- go to newer position in jumplist
-- TODO: Eventuell ib, iB und it in visual mode

-- Map default behavior of neio keys to hjkl, in the way that: l does now what n did, h does now what e did, j does now what i did, k does now what o did:
-- nmap('l', 'n')
-- vmap('l', 'n')
-- nmap('L', 'N') -- search in other direction
-- vmap('L', 'N') -- search in other direction
-- imap('<C-l>', '<C-n>') -- insert (auto-complete) next match before the cursor during insert mode

-- nmap('h', 'e')
-- vmap('h', 'e')
-- nmap('H', 'E') -- back word end
-- vmap('H', 'E') -- back word end
-- nmap('<C-h>', '<C-e>') -- move screen down one line without moving cursor
-- vmap('<C-h>', '<C-e>') -- move screen down one line without moving cursor

-- nmap('j', 'i')
-- nmap('J', 'I') -- insert at beginning of line
-- vmap('j', 'i')
-- vmap('J', 'I') -- insert at beginning of line
-- nmap('<C-j>', '<C-i>') -- ATTENTION: This cannot be mapped, mapping Ctrl+i will break the tab key, since Ctrl+i is its terminal composed character sequence. See https://unix.stackexchange.com/questions/563469/conflict-ctrl-i-with-tab-in-normal-mode and https://vi.stackexchange.com/questions/25473/tab-does-not-work-with-vim-for-me -- go to newer position in jumplist
-- -- TODO: Eventuell ib, iB und it in visual mode
--
-- nmap('k', 'o')
-- vmap('k', 'o') -- move to other end of marked area
-- vmap('K', 'O') -- move to other end of block
-- nmap('<C-k>', '<C-o>') -- go to older position in jumplist
-- omap('k', 'i') -- For text object to the bottom
-- --nmap('K', 'O') this has been done above with kk and KK

-- TODO: Add colemak mappings for CTRL-W + hjkl for changing split windows, and also rearranging them

-- imap('', '<Tab>')
-- --------------------------



vim.g.mapleader = ' '                           -- Map leader key to space
vim.g.maplocalleader = ' '                      -- Make local leader key same as leader key, required by vimtex, see https://stackoverflow.com/questions/26837425/vim-how-to-use-the-control-key-as-my-local-leader
-- TODO: The following lines are disabled because they do not make sense on colemak
-- imap('jk', '<Esc>')                             -- Map jk to escape from insert mode to prevent reaching for escape - If needing to type literal jk, one has to wait one to two seconds between presses, see https://vim.fandom.com/wiki/Avoid_the_escape_key
-- vmap('jk', '<Esc>')                             -- Map jk to escape from visual mode

-- Map putting in visual mode so that text stays selected, but not if using capital P . Capital P is normally used to put text in visual mode, and not yank it to register, because small p yanks overwritten text to register
vmap('p', 'Pgv')
vmap('P', 'P')
-- xmap('p', 'c<c-r><c-r>0<esc>') -- Fix visual paste repeat, see https://vi.stackexchange.com/questions/34850/is-it-possible-to-properly-repeat-a-visual-replacement and https://www.reddit.com/r/vim/comments/qhd2pv/is_it_possible_to_properly_repeat_a_visual/
-- Map to visually select last pasted text:
nmap('gp', "`[v`]")

nmap('S', ':%s//gI<Left><Left><Left>')-- TODO: Maybe polish this with below call command?                 -- Map capital S to replace all, I tag needed to make case sensitive after o.ignorecase or so has been set
-- :autocmd FileType tex          iabbrev fr \frac{ENUMERATOR}{DENOMINATOR}<Esc>?ENUMERATOR<CR>dwh:call InsertInput("Enumerator")<CR><Esc>?DENOMINATOR<CR>dwh:call InsertInput("Denominator")<CR>a<right>

-- TODO: This is legacy, since neovim 0.11 the bindings [<Space and ]<Space do this
-- nmap('kk', 'o<Esc>')                           -- Insert empty line below current line
-- nmap('KK', 'O<Esc>')                            -- Insert empty line above current line

-- Delete without yanking
nmap('d', '"_d')
nmap('dd', '"_dd')
nmap('D', '"_D')
vmap('d', '"_d')
vmap('D', '"_D')
-- Change without yanking
nmap('c', '"_c')
nmap('cc', '"_cc')
nmap('C', '"_C')
vmap('c', '"_c')
vmap('C', '"_C')
-- Delete single characters without yanking
nmap('x', '"_x')
nmap('X', '"_X')
vmap('x', '"_x')
vmap('X', '"_X')
-- Substitute without yanking (Capital s is already mapped to replace all)
nmap('s', '"_s')
vmap('s', '"_s')
-- Delete with yanking = Cut (Is equivalent to default behaviour of d and D)
nmap('<Leader>d', 'd')
nmap('<Leader>dd', 'dd')
nmap('<Leader>D', 'D')
vmap('<Leader>d', 'd')
vmap('<Leader>D', 'D')
-- Change with yanking = Cut (Is equivalent to default behaviour of c and C)
nmap('<Leader>c', 'c')
nmap('<Leader>cc', 'cc')
nmap('<Leader>C', 'C')
vmap('<Leader>c', 'c')
vmap('<Leader>C', 'C')
-- Delete single characters with yanking = Cut (Is equivalent to default behaviour of x and X)
nmap('<Leader>x', 'x')
nmap('<Leader>X', 'X')
vmap('<Leader>x', 'x')
vmap('<Leader>X', 'X')
-- Substitute with yanking via leader (Is equivalent to default behaviour of s)
nmap('<Leader>s', 's')
vmap('<Leader>s', 's')
-- Make change whole line ("cc") start at first non-blank character, so that it does not delete the indentation:
nmap('cc', '_"_C') -- need "_ so yank also gets blackholed
-- TODO: Maybe make CC use the old behavior of cc, so that it deletes the indentation? But would mean delay when using single C

-- Map for easier window tile navigation
nmap('<C-e>', '<C-W><C-J>')
nmap('ႭჃႳ', '<C-W><C-K>') -- see alacritty config for the meaning of this symbol, mapped to ctrl+i binding, see https://medium.com/@jogarcia/alacritty-with-tmux-escape-sequence-for-custom-binding-47df5e401c51
nmap('<C-o>', '<C-W><C-L>')
nmap('<C-n>', '<C-W><C-H>')
nmap('<C-E>', '<C-W>J')
nmap('ႴႭჃႳ', '<C-W>K') -- see alacritty config for the meaning of this symbol, mapped to ctrl+i binding, see https://medium.com/@jogarcia/alacritty-with-tmux-escape-sequence-for-custom-binding-47df5e401c51
nmap('<C-O>', '<C-W>L')
nmap('<C-N>', '<C-W>H')
-- Map for easier window tile resizing
nmap('<C-Up>', '<C-W>+')
nmap('<C-Down>', '<C-W>-')
nmap('<C-Left>', '<C-W><')
nmap('<C-Right>', '<C-W>>')
nmap('<C-M>', '<C-W>=')

-- Map to switch jumping to marks accent aigu and apostrophe, because accent aigu does not work when dead keys are enabled, and jumping to line and column is more important:
nmap("'", '`')
nmap("`", "'")

-- Prevent cursor from shifting to left after enter-leaving the insert mode: -- TODO: Disabled experimentally
-- vim.g.CursorColumnI = 0                        -- the cursor column position in INSERT
-- vim.cmd('autocmd InsertEnter * let CursorColumnI = col(".")')-- TODO: Do all these in proper lua
-- vim.cmd('autocmd CursorMovedI * let CursorColumnI = col(".")')
-- vim.cmd('autocmd InsertLeave * if col(".") != CursorColumnI | call cursor(0, col(".")+1) | endif')
-- Map File explorer to CTRL+n TODO: This all has been disabled in favor of yazi.nvim plugin
-- nmap('<C-p>', ':Explore! <CR>') -- CTRL+p seems to be the convention for doing this, see https://youtu.be/DIWr3FkQnnc?feature=shared&t=164
-- nmap('<Leader><C-p>', ':FuzzyOpen <CR>') -- Open fuzzy finder for file names
-- -- Set netrw settings:
-- vim.g.netrw_list_hide = '^\\./$,^\\.\\./$'
-- vim.g.netrw_hide = 1
-- -- vim.g.netrw_keepdir = 0 -- TODO: Does conflict with autochdir, see https://vi.stackexchange.com/questions/34557/how-can-i-use-let-gnetrw-keepdir-0-for-folders-and-autochdir-for-files -- keep working dir same as browsing dir while using netrw, see https://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
-- -- Fix netrw bug where when jumping back to it via ctrl+o it will not actually open netrw, but a different buffer (either unnamed buffer or buffer from before), see https://www.reddit.com/r/neovim/comments/14mftou/jumplist_with_netrw/ and https://github.com/neovim/neovim/issues/24721
-- -- For this solution see https://www.reddit.com/r/neovim/comments/14mftou/jumplist_with_netrw/
-- vim.g.netrw_fastbrowse = 2
-- vim.g.netrw_keepj = ""

-- Command to open buffer explorer and promt for number of desired buffer (enter number and press enter) (source see https://vim.fandom.com/wiki/Easier_buffer_switching#Switching_by_number)
nmap('<Leader>b', ':buffers<CR>:buffer<Space>') -- To go to previous buffer use CTRL+6 or CTRL+^ by default

-- Command to correct last/next error to first recommended spelling:
nmap('<Leader>z', '[s1z=gi<ESC>l')
nmap('<Leader>Z', ']s1z=gi<ESC>l')

-- LSP mappings:
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts) -- source https://blog.pabuisson.com/2022/08/neovim-modern-features-treesitter-and-lsp/
-- Default mappings provided since neovim 0.11 (see https://gpanders.com/blog/whats-new-in-neovim-0-11/):
-- vim.lsp.buf.rename() is mapped to grn
-- vim.lsp.buf.references() is mapped to grr
-- vim.lsp.buf.implementation() is mapped to gri
-- vim.lsp.buf.document_symbol() is mapped to gO


-- Map capital U to redo instead of ctrl+r and restore state of last changed line to leader+capital U instead of capital U:
nmap('U', '<C-R>')
nmap('<Leader>U', 'U')

-- -- Mapping to display register list and paste content of register that is selected by "number/letter" + "enter" at the bottom prompt in the split window that shows the registers: (Source: https://vi.stackexchange.com/questions/8467/how-can-i-easily-list-the-content-of-the-registers-before-pasting/8468#8468) -- TODO: This does not work yet
-- nmap('<Leader>p', ':reg <bar> exec \'normal! "\'.input(\'>\').\'p\'<CR>') -- TODO: This does not seem to work yet, numbered register contents are way too old
-- Mapping to put register with space in front, as often would be convenient:
nmap('<Leader>p', 'a <ESC>p')
-- Mapping to put the contents of the register without the leading newline: -- TODO
nmap('<Leader>P', 'pbJ')

-- Mapping to split line at cursor (inverse to capital J) (and also remove trailing space if there is one in the remaining upper line):
nmap('<Leader>E', 'i<CR><ESC>k:s/ $//<CR>$')

-- Mappings for terminal mode, see https://gist.github.com/mahemoff/8967b5de067cffc67cec174cb3a9f49d
nmap('<Leader>t', ':terminal<CR>')
-- Always enter insert mode when entering terminal buffer (important e. g. when returning to gitui window from edit):
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, { -- Source see https://vi.stackexchange.com/questions/3670/how-to-enter-insert-mode-when-entering-neovim-terminal-pane/3765#3765
    pattern = "term://*",
    callback = function()
        -- Set terminal-specific options
        vim.opt_local.spell = false
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false

        -- Terminal mode escape key mapping
        vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', '<C-\\><C-N>:bd!<CR>', { noremap = true, silent = true })

        -- Start terminal in insert mode
        vim.cmd("startinsert")
    end
})

-- Mapping to open float with list of lsp errors on current line:
nmap('go', ':lua vim.diagnostic.open_float()<CR>') -- the usual keymap is "gl", which becomes "go" in colemak
vim.diagnostic.config({
  float = {
    border = "rounded", -- Rounded borders for the floating window
    source = "always",  -- Show the source of the diagnostic
    header = "",        -- Remove the "Diagnostics" header
    prefix = "‣ ",      -- Add a bullet point before each message
  }
})
-- vim.api.nvim_set_hl(0, "NormalFloat", {bg="#FFFFFF"}) -- TODO Bkg is not usual color

-- Mapping to force gf to go edit file even if it does not exist for use in note taking/wiki creation to quickly make new notes:
nmap('gf', ':e <cfile><CR>')
-- Function to browse forward links in note:
function notes_browse_links()
    local bufname = vim.api.nvim_buf_get_name(0)
    vim.cmd(':e Browse links')
    vim.bo.buftype = 'nofile' -- So there wont be buffer change warning
    vim.bo.bufhidden = 'hide' -- So it wont clog up the buffer list when switching through, cant be unloaded so Ctrl-i and ctrl-o work
    local grephandle = io.popen( 'rg -os "\\./\\w*" ' .. bufname .. ' | sort -u' ) -- sort -u sorts alphabetically and removes duplicates
    local grepoutput = grephandle:read("*a")
    grephandle:close()
    local grepoutputarray = {}
    for line in grepoutput:gmatch '[^\n]+' do
        table.insert(grepoutputarray, line:gsub('./',''))
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, grepoutputarray)
end
vim.keymap.set('n', '<Leader>nL', notes_browse_links, { noremap = true, silent = true })
-- Function to browse backward links in note:
function notes_browse_backlinks()
    local filename = vim.fn.expand('%:t')
    vim.cmd(':e Browse backlinks')
    vim.bo.buftype = 'nofile' -- So there wont be buffer change warning
    vim.bo.bufhidden = 'hide' -- So it wont clog up the buffer list when switching through, cant be unloaded so Ctrl-i and ctrl-o work
    local grephandle = io.popen( 'rg -Fls "./' .. filename .. '" * | sort -u' )
    local grepoutput = grephandle:read("*a")
    grephandle:close()
    local grepoutputarray = {}
    for line in grepoutput:gmatch '[^\n]+' do
        table.insert(grepoutputarray, line)
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, grepoutputarray)
end
vim.keymap.set('n', '<Leader>nB', notes_browse_backlinks, { noremap = true, silent = true })
-- Mapping leader + nl to browse forward links in note that are not explicitly links (with ./), but are just plain words:
function notes_browse_words()
    local bufname = vim.api.nvim_buf_get_name(0)
    vim.cmd(':e Browse words')
    vim.bo.buftype = 'nofile' -- So there wont be buffer change warning
    vim.bo.bufhidden = 'hide' -- So it wont clog up the buffer list when switching through, cant be unloaded so Ctrl-i and ctrl-o work
    local rghandle = io.popen( 'rg -os "\\w*" ' .. bufname .. ' | sort -u' )
    local rgoutput = rghandle:read("*a")
    rghandle:close()
    local lshandle = io.popen( 'ls -1' )
    local lsoutput = lshandle:read("*a")
    lshandle:close()
    local outputarray = {}
    -- Check that the word exists as file:
    for rgline in rgoutput:gmatch '[^\n]+' do
        for lsline, i in lsoutput:gmatch '[^\n]+' do -- use different regex here because gmatch does not work with caret characters when also taking index variable
            if rgline == lsline then
                table.insert(outputarray, rgline)
                -- TODO: Remove first i lines from lsoutput, so that it is not searched through again, because of alphabetic ordering
                break
            end
        end
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, outputarray)
end
vim.keymap.set('n', '<Leader>nl', notes_browse_words, { noremap = true, silent = true })
-- Function to browse backward words in note:
function notes_browse_backwords()
    local filename = vim.fn.expand('%:t')
    vim.cmd(':e Browse backwords')
    vim.bo.buftype = 'nofile' -- So there wont be buffer change warning
    vim.bo.bufhidden = 'hide' -- So it wont clog up the buffer list when switching through, cant be unloaded so Ctrl-i and ctrl-o work
    local grephandle = io.popen( 'rg -Fls "' .. filename .. '" * | sort -u' )
    local grepoutput = grephandle:read("*a")
    grephandle:close()
    local grepoutputarray = {}
    for line in grepoutput:gmatch '[^\n]+' do
        table.insert(grepoutputarray, line)
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, grepoutputarray)
end
vim.keymap.set('n', '<Leader>nb', notes_browse_backwords, { noremap = true, silent = true })


-- Mapping to prevent deselecting visually selected text when indenting or unindenting it:
vmap('<', '<gv')
vmap('>', '>gv')

-- Mapping to search for visually selected text:
vmap('//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>') -- See https://vim.fandom.com/wiki/Search_for_visually_selected_text#Simple

-- Save and quit file from insert and normal mode:
imap('<C-s>', '<Esc>:lua if vim.bo.modified then vim.cmd("w") end if #vim.fn.getbufinfo({buflisted = 1}) > 1 then vim.cmd("bd") else vim.cmd("q") end<CR>')
nmap('<C-s>', ':lua if vim.bo.modified then vim.cmd("w") end if #vim.fn.getbufinfo({buflisted = 1}) > 1 then vim.cmd("bd") else vim.cmd("q") end<CR>')

-- TODO: The following has been replaced by m4xshen/autoclose.nvim, but has been reactivated, because autoclose seems to cause unnecessary lag
-- Brackets and Braces completion (Source: https://vim.fandom.com/wiki/Automatically_append_closing_characters) TODO: THIS CAUSES MUCH LAG WHEN TYPING IN FRONT OF CLOSING BRACKET or similar
-- Curly Brackets:
imap('{', '{}<Left>')
imap('{<CR>', '{<CR>}<Esc>O')
imap('{{', '{')
imap('{}', '{}')
imap('}', '<C-R>=strpart(getline(\'.\'), col(\'.\')-1, 1) == \"}\" ? \"\\<lt>Right>\" : \"}\"<CR>')-- Skip placement of closing brackets if already present, used backward compatible vim version which does not use <expr> matching but register instead, because otherwise it would not work with lua, see https://vim.fandom.com/wiki/Automatically_append_closing_characters#Backwards-compatible_closing_brace_skip
-- Parentheses:
imap('(', '()<Left>')
imap('(<CR>', '(<CR>)<Esc>O')
imap('((', '(')
imap('()', '()')
imap(')', '<C-R>=strpart(getline(\'.\'), col(\'.\')-1, 1) == \")\" ? \"\\<lt>Right>\" : \")\"<CR>')-- Skip placement of closing brackets if already present
-- Square Brackets:
imap('[', '[]<Left>')
imap('[<CR>', '[<CR>]<Esc>O')
imap('[[', '[')
imap('[]', '[]')
imap(']', '<C-R>=strpart(getline(\'.\'), col(\'.\')-1, 1) == \"]\" ? \"\\<lt>Right>\" : \"]\"<CR>')-- Skip placement of closing brackets if already present
-- Double Quotes (Same character comletions are a little different in the last line, see source):
imap('\"', '\"\"<Left>')
imap('\"<CR>', '\"<CR>\"<Esc>O')
imap('\"\"', '\"')
vim.api.nvim_set_keymap('i', '"', 'strpart(getline("."), col(".")-1, 1) == "\\"" ? "\\<Right>" : "\\"\\"\\<Left>"', { expr = true, noremap = true, silent = true }) -- Skip placement of closing quotes if already present (Notice the expr option in contrast to the default imap function)
-- Single Quotes:
imap("\'", "\'\'<Left>")
imap("\'<CR>", "\'<CR>\'<Esc>O")
imap("\'\'", "\'")
vim.api.nvim_set_keymap('i', "'", 'strpart(getline("."), col(".")-1, 1) == "\'" ? "\\<Right>" : "\'\'\\<Left>"', { expr = true, noremap = true, silent = true }) -- Skip placement of closing quotes if already present
-- Backtick:
imap("`", "``<Left>")
imap("`<CR>", "`<CR>`<Esc>O")
imap("``", "`")
vim.api.nvim_set_keymap('i', "`", 'strpart(getline("."), col(".")-1, 1) == "`" ? "\\<Right>" : "``\\<Left>"', { expr = true, noremap = true, silent = true }) -- Skip placement of closing quotes if already present
-- Dollar Sign (only in tex and bib files, annoying otherwise):
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'tex', 'bib' },
    callback = function()
        imap('$', '$$<Left>')
        imap('$<CR>', '$<CR>$<Esc>O')
        imap('$$', '$$')
        vim.api.nvim_set_keymap('i', '$', 'strpart(getline("."), col(".")-1, 1) == "\\$" ? "\\<Right>" : "\\$\\$\\<Left>"', { expr = true, noremap = true, silent = true }) -- Skip placement of closing quotes if already present
        -- Speed optimizations against laggy cursor in long documents (see and :h tex-slow)
        vim.opt_local.cursorline = false -- Otherwise cursor can lag when moving/deleting characters
        vim.opt_local.cursorcolumn = false -- Otherwise cursor can lag when moving/deleting characters
        vim.opt_local.relativenumber = false -- Otherwise cursor can lag when moving/deleting characters
        vim.cmd("NoMatchParen") -- Otherwise cursor can lag when moving/deleting characters
        vim.cmd("syn sync maxlines=300")
    end,
    group = templates
})
-- Execute python code
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'python' },
    callback = function()
        imap('<F5>', '<ESC>:!python3 %<CR>') -- Execute python code
        nmap('<F5>', ':!python3 %<CR>') -- Execute python code
        -- vim.bo.tw = 79 -- Set textwidth to 79 for python, as recommended in PEP8 -- TODO: This has been turned off because it does not break strings intelligently, resulting in frustrating formatting
    end,
    group = compile_execute
})
-- Compile and execute Rust code with cargo run
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'rust' },
    callback = function()
        imap('<F5>', '<ESC>:!cargo run<CR>') -- Execute python code
        nmap('<F5>', ':!cargo run<CR>') -- Execute python code
    end,
    group = compile_execute
})
-- Compile groff document
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'groff' },
    callback = function()
        imap('<F5>', '<Esc>:!ff %<CR>') -- Compile groff document
        nmap('<F5>', ':!ff %<CR>') -- Compile groff document
    end,
    group = templates
})
-- Compile and execute Fortran code with gfortran:
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'fortran' },
    callback = function()
        imap('<F5>', '<ESC>:!gfortran % -o %:r && ./%:r<CR>') -- Compile and execute Fortran code
        nmap('<F5>', ':!gfortran % -o %:r && ./%:r<CR>') -- Compile and execute Fortran code
    end,
    group = compile_execute
})
-- Compile and execute C code with gcc:
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c' },
    callback = function()
        -- Development build (F5)
        vim.keymap.set("n", "<F5>", function()
            vim.bo.makeprg = "gcc -std=c99 -ggdb3 -O0 -fsanitize=address % -o %:r" -- ggdb3 is for additional debug info, O0 is for keeping all variables visible by doing no optimization (-Og would still do this, even if it says in the manual that it is better for debugging), -fsanitize=address is a tracer (?) against memory leaks
            vim.cmd("make | if !empty(getqflist()) | copen | endif") -- make, and show output, then open quickfix list but if it is non-empty (I believe qfl gets populated by "make")
            end, { buffer = true })
        vim.keymap.set("i", "<F5>", function()
            vim.cmd("stopinsert")
            vim.cmd("write")
            vim.bo.makeprg = "gcc -std=c99 -ggdb3 -O0 -fsanitize=address % -o %:r"
            vim.cmd("make | if !empty(getqflist()) | copen | endif")
            end, { buffer = true })
        -- Production build (Shift-F5 => F17)
        vim.keymap.set("n", "<F17>", function()
            vim.bo.makeprg = "gcc -std=c99 -Wall -Werror -O3 -s -DNDEBUG % -o %:r" -- specify version, all warnings as errors, use level 3 optimization, strip debug symbols, turn off asserts
            vim.cmd("make | if !empty(getqflist()) | copen | endif")
            end, { buffer = true })
        vim.keymap.set("i", "<F17>", function()
            vim.cmd("stopinsert")
            vim.cmd("write")
            vim.bo.makeprg = "gcc -std=c99 -Wall -Werror -O3 -s -DNDEBUG % -o %:r" -- specify version, all warnings as errors, use level 3 optimization, strip debug symbols, turn off asserts
            vim.cmd("make | if !empty(getqflist()) | copen | endif")
            end, { buffer = true })
        -- -- When building for release use "gcc -std=c99 -O3 -s -DNDEBUG", specify version, use level 3 optimization, strip debug symbols, turn off asserts
        -- imap('<F5>', '<ESC>:!gcc -std=c99 -ggdb3 -Og -fsanitize=address -fdiagnostics-color=always % -o %:r && ./%:r<CR>') -- Compile and execute C code for debugging and development
        -- nmap('<F5>', ':!gcc -std=c99 -ggdb3 -Og -fsanitize=address -fdiagnostics-color=always % -o %:r && ./%:r<CR>') -- Compile and execute C code for debugging and development
        -- imap('<F17>', '<ESC>:!gcc -std=c99 -Wall -Werror -O3 -s -DNDEBUG -fsanitize=address -fdiagnostics-color=always % -o %:r && ./%:r<CR>') -- Compile and execute C code for production (Press Shift-F5 for this)
        -- nmap('<F17>', ':!gcc -std=c99 -Wall -Werror -O3 -s -DNDEBUG -fsanitize=address -fdiagnostics-color=always % -o %:r && ./%:r<CR>') -- Compile and execute C code for production (Press Shift-F5 for this)
    end,
    group = compile_execute
})
-- compile and execute C++ code with g++:
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cpp' },
    callback = function()
        imap('<F5>', '<ESC>:!g++ % -o %:r && ./%:r<CR>') -- Compile and execute C++ code
        nmap('<F5>', ':!g++ % -o %:r && ./%:r<CR>') -- Compile and execute C++ code
    end,
    group = compile_execute
})


-- Make each character in list below work as text object for latex selection, see https://vi.stackexchange.com/questions/12146/refer-to-text-between-arbitrary-delimiting-characters
local chars = { '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '$', '=', "<Space>" }
for _, char in ipairs(chars) do
    vim.api.nvim_set_keymap('x', 'i' .. char, ':<C-u>normal! T' .. char .. 'vt' .. char .. '<CR>', { silent = true })
    vim.api.nvim_set_keymap('o', 'i' .. char, ':normal vi' .. char .. '<CR>', { silent = true })
    vim.api.nvim_set_keymap('x', 'a' .. char, ':<C-u>normal! F' .. char .. 'vf' .. char .. '<CR>', { silent = true })
    vim.api.nvim_set_keymap('o', 'a' .. char, ':normal va' .. char .. '<CR>', { silent = true })
end

-- Commands -----------------------------
vim.cmd('command! WipeRegs for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor | :wsh!')-- TODO: This must be done in proper lua, vim.cmd is a workaround                -- Wipe all registers (Source: https://stackoverflow.com/questions/19430200/how-to-clear-vim-registers-effectively/41003241#41003241)


-- Plugins -----------------------------
-- Bootstrap lazy.nvim plugin manager:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- Set plugins and options for lazy.nvim:
local plugins = {
    'lewis6991/gitsigns.nvim',
    -- 'zbirenbaum/copilot.lua',
    'jhawthorn/fzy',
    'cloudhead/neovim-fuzzy',
--    'tpope/vim-repeat',
    'neovim/nvim-lspconfig', -- TODO: This is legacy since neovim 0.11+ does it natively, see https://gpanders.com/blog/whats-new-in-neovim-0-11/
    'lervag/vimtex', -- TODO: On the vimtex github it says not to lazyload vimtex, as it will cause inverse search to fail
    { 'chomosuke/typst-preview.nvim',
      ft = 'typst', -- or lazy = false
      version = '1.*',
      opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    },
    { 'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = function() vim.fn['mkdp#util#install']() end,
    },
--   'anott03/nvim-lspinstall', -- TODO: Can perhaps use anott03/nvim-lspinstall to automatically boostrap needed language servers
--   'nvimdev/lspsaga.nvim', -- TODO: Is recommended on https://www.notonlycode.org/neovim-lua-config/ , but not clear what it does
    { 'L3MON4D3/LuaSnip', -- For inspiration and tips see https://cj.rs/blog/ultisnips-to-luasnip/ and https://evesdropper.dev/files/luasnip/ultisnips-to-luasnip/
        dependencies = { "rafamadriz/friendly-snippets" }, -- For this to not slow down loading, require("luasnip.loaders.from_vscode").lazy_load() must be activated, see below. Do work, but are not good. See also plugin luasnip-latex-snippets.nvim
    },
    --'evesdropper/luasnip-latex-snippets.nvim', -- Do work, but are not good. See also plugin friendly-snippets.
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/nvim-cmp', -- Completions, but needs setup to work for each specific language
    'hrsh7th/cmp-nvim-lsp', -- For this and the following three plugins see recommended config on https://github.com/hrsh7th/nvim-cmp -- TODO: This is legacy since neovim 0.11+ does it natively, see https://gpanders.com/blog/whats-new-in-neovim-0-11/
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-refactor', -- Use refactor functionality to implement jump to definition etc, see https://github.com/nvim-treesitter/nvim-treesitter-refactor?tab=readme-ov-file#navigation
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'petertriho/cmp-git',
    'nvim-lua/plenary.nvim', -- dependency of cmp-git
    'hrsh7th/cmp-omni', -- For Latex support, see https://github.com/lervag/vimtex/issues/2215
    'hrsh7th/cmp-cmdline',
    -- { url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }, -- For wrapping lsp inline diagnostics in new lines
    -- 'vim-airline/vim-airline', -- Airline makes sshfs files lag to unusable degrees, see similar powerline issue: https://github.com/powerline/powerline/issues/549
    -- 'vim-airline/vim-airline-themes',
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- { 'zbirenbaum/copilot-cmp', -- See https://www.reddit.com/r/neovim/comments/twe45i/copilotlua_copilotcmp_pure_lua_plugins_for_github/ , for this installation thing see https://github.com/zbirenbaum/copilot-cmp
    --     config = function()
    --         require('copilot_cmp').setup()
    --     end },
    { "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            -- TO surround word with latex funcxtion use ysiwc and get prompted for command, to surround visual selection in environment press c , for the source see https://github.com/kylechui/nvim-surround/discussions/53#discussioncomment-3142459
                surrounds = {
                    ["c"] = {
                        add = function()
                            local cmd = require("nvim-surround.config").get_input "Command: "
                            return { { "\\" .. cmd .. "{" }, { "}" } }
                        end,
                    },
                    ["e"] = {
                        add = function()
                            local env = require("nvim-surround.config").get_input "Environment: "
                            return { { "\\begin{" .. env .. "}", "" }, { "\\end{" .. env .. "}" } }
                        end,
                    },
                },
            })
        end
    },
    -- "m4xshen/autoclose.nvim", -- This seems to cause to much lag, see manual implementation below
    --"PhilGrunewald/vim-py-kid", -- TODO: This was an alternative to a jupyter notebook, but it does not work well
    "gentoo/gentoo-syntax",
    {
      "mikavilpas/yazi.nvim",
      event = "VeryLazy",
      dependencies = {
        -- check the installation instructions at
        -- https://github.com/folke/snacks.nvim
        "folke/snacks.nvim"
      },
      keys = {
        -- 👇 in this section, choose your own keymappings!
        {
          "<leader><C-p>",
          mode = { "n", "v" },
          "<cmd>Yazi<cr>",
          desc = "Open yazi at the current file",
        },
        {
          -- Open in the current working directory
          "<leader>cw",
          "<cmd>Yazi cwd<cr>",
          desc = "Open the file manager in nvim's working directory",
        },
        {
          "<C-p>",
          "<cmd>Yazi toggle<cr>",
          desc = "Resume the last yazi session",
        },
      },
      ---@type YaziConfig | {}
      opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = true,
        keymaps = {
          show_help = "<f1>",
        },
      },
      -- 👇 if you use `open_for_directories=true`, this is recommended
      init = function()
        -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
      end,
    },
}
local opts = {}
require("lazy").setup({ plugins, opts }) -- Start lazy.nvim TODO: Lazyloading does need to be enabled explicitly, but some plugins may need to be excluded from lazyloading, see http://www.lazyvim.org/configuration/lazy.nvim and e.g. https://github.com/lervag/vimtex/issues/2996#issuecomment-2359489726
-- require('copilot').setup({
--     suggestion = { enabled = false },
--     panel = { enabled = false },
--     filetypes = {
--           yaml = true,
--           markdown = true,
--           help = true,
--           svn = true,
--           cvs = false,
--           gitcommit = true,
--           gitrebase = true,
--           ["."] = true,
--     },
-- })
require('gitsigns').setup({ -- Setup gitsigns plugin, see Source: https://github.com/lewis6991/gitsigns.nvim
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end
    -- Navigate between hunks with ]c and [c
    map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, {expr=true})
    map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, {expr=true})
    -- Diffthis mapping:
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hd', gs.diffthis) -- TODO: This throws errors
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map({'o', 'x'}, 'ah', ':<C-U>Gitsigns select_hunk<CR>') -- TODO: here default ih mapping might collide with colemak navkeys, using ah instead of ih, check if this works
end
})
-- require'lspconfig'.pyright.setup{} -- Setup pyright language server for python - IF THIS FAILS, MAY NEED TO RUN CONSOLE COMMAND 'npm i -g pyright', see Source: https://github.com/neovim/nvim-lspconfig -- TODO: In the github it says: "nvim-lspconfig does not set keybindings or enable completion by default" - so look at "suggested configuration" paragraph -- TODO: Install html, shell and latex language servers/lsps # TODO: Add suggested keybindings, especially for "jump to definition"
-- TODO: For basedpyright install see https://github.com/LazyVim/LazyVim/discussions/3350
require'lspconfig'.bashls.setup{} -- Setup bash language server, for config of filetypes see https://smarttech101.com/nvim-lsp-configure-language-servers-shortcuts-highlights/#configure_each_server_separately -- TODO: This is legacy since neovim 0.11+ does it natively, see https://gpanders.com/blog/whats-new-in-neovim-0-11/
require("luasnip.loaders.from_vscode").lazy_load() -- This is needed in case of luasnips, otherwise vim may load very slowly, see https://github.com/rafamadriz/friendly-snippets#with-lazynvim
--
-- Texlab latex language server setup: -- TODO: This is legacy since neovim 0.11+ does it natively, see https://gpanders.com/blog/whats-new-in-neovim-0-11/
require'lspconfig'.texlab.setup{
    settings = {
        texlab = {
            build = {
                -- useFileList = true, -- This enables bibliography and images in subfolders defined in seperate packages etc. to be recognized by texlab (https://github.com/latex-lsp/texlab/issues/1145), but may drastically reduce startup time if .fls file is too big (https://github.com/latex-lsp/texlab/pull/1160)
                -- TODO the issue with the undefined references is fixed by adding \bibliography{name.bib}{} in the beginning of the document. This is what the personal custom package does in dobibliography, but  
            },
            experimental = {
                followPackageLinks = true, -- for including definitions from custom userdefined packages
                mathEnvironments = {'align', 'equation', 'align*', 'equation*'}, -- Otherwise these environments are not recognized in part
                enumEnvironments = {'enumerate', 'itemize'}, -- Otherwise these environments are not recognized in part
                -- Recognize custom include figures for quick completion:
                labelDefinitionCommands = {'incfig'},
                labelDefinitionPrefixes = {{'incfig', 'fig:'}},
            }
        }
    }
}
-- TODO: This is legacy since neovim 0.11+ does it natively, see https://gpanders.com/blog/whats-new-in-neovim-0-11/
require("lspconfig")["tinymist"].setup {
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onSave",
        semanticTokens = "enable",
    }
}
-- See e.g. https://github.com/latex-lsp/texlab/wiki/Configuration#texlabexperimentalfollowpackagelinks
--vim.g.texlab.experimental.followPackageLinks = true -- for including definitions from custom userdefined packages
--vim.g.texlab.experimental.mathEnvironments = {'align', 'equation', 'align*', 'equation*'} -- Otherwise these environments are not recognized in part
--vim.g.texlab.experimental.enumEnvironments = {'enumerate', 'itemize'} -- Otherwise these environments are not recognized in part
-- texlab.experimental.citationCommands = {}, -- Just for reference, there are also some more options like this one and the one above

-- Options for plugins
-- VIMTEX
vim.g.vimtex_view_method = 'zathura' -- Use zathura as pdf viewer
-- Exit vim if quickfix window is last window on screen (Source https://vim.fandom.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last):
vim.g.vimtex_complete_bib_simple = 1 -- Enable sorting after accuracy of match in citation completion, see https://github.com/lervag/vimtex/issues/1265#issuecomment-443894124
vim.g.vimtex_indent_lists = {} -- disable indentation of lists, and thus items in itemize, temporary fix to weird default vimtex indentation, see https://github.com/lervag/vimtex/issues/2599
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_ignore_filters = { 'Overfull', 'Underfull'}
--vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1 -- TODO: This closes the quickfix window when work on the document is resumed, but close on successful compilation wound be preferable, possibly with binding <Leader>ll (compilation shortcut) to compilation+closing quickfix window, but that would also need to be done for saving
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        -- if the window is quickfix go on
        if vim.bo.buftype == "quickfix" then
            -- if this window is last on screen quit without warning
            if vim.fn.winbufnr(2) == -1 then
                vim.cmd('quit')
            end
        end
    end,
    group = grp
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        vim.keymap.set("i", "<CR>", function()
            return vim.fn.getline("."):match("^%s*\\item%s+.+$")
                and "<esc>o\\item <esc>a"
                or "<CR>"
        end, { expr = true, buffer = true })
        -- -------- Provide functionality to only compile on save:
        -- Initialize buffer local flag vimtex_compile to false:
        vim.b.vimtex_compile = false
        -- Overwrite leader+ll keymap to toggle vimtex_compile flag true and if true, compile document as single shot:
        vim.keymap.set("n", "<Leader>ll", function()
            vim.b.vimtex_compile = not vim.b.vimtex_compile
            if vim.b.vimtex_compile then
                vim.cmd("VimtexCompileSS")
            end
        end, { buffer = true })
        -- Overwrite save command to do a single shot compile if vimtex_compile flag is true: -- TODO: instead use a autocmd BufWritePost for filetype tex, so that w does not get overwritten for e.g. bib files
        function compile_tex_ifflag()
            if vim.b.vimtex_compile then
                vim.cmd("VimtexCompileSS")  -- Trigger VimtexCompileSS for LaTeX compilation
            end
        end
        vim.cmd([[
            command! -buffer -nargs=* WRITECOMPILETEX write <args> | lua compile_tex_ifflag()
        ]])
        -- Hack to circumvent lowercase user defined command prohibition, source:
        vim.cmd([[
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("w","WRITECOMPILETEX")
]])
-- TODO: Maybe setup command alias in LUA instead, see https://stackoverflow.com/questions/3878692/how-to-create-an-alias-for-a-command-in-vim/69951171#69951171

    end,
})
-- VIMTEX-LIVE-PREVIEW
-- vim.g.livepreview_previewer = 'zathura' -- Use zathura as pdf viewer-- TODO:It seems to work without this line, so maybe it is not needed, but this is a little suspicious, would only make sense if zathura is the only compatible reader it can find
-- TODO: Let Vimtex syntax highliting recognize some greek characters as normal characters, so that they can be used in math mode, with e. g. the following commands (Source: https://vi.stackexchange.com/questions/19040/add-keywords-to-a-highlight-group/19043#19043): " TODO Probably gets overwritten by vimtex plugin loading i somethign afterwards, even though earlier in the file
-- ":syntax keyword LatexGreekLetters α β γ δ ε ζ η θ ι κ λ μ ν ξ π ρ σ τ υ φ χ ψ ω Γ Δ Θ Λ Ν Ρ Σ Υ Φ Ψ Ω
-- ":highlight def link LatexGreekLetters Special
-- TODO: Adjust group in the line above, for groups see http://www.drchip.org/astronaut/vim/syntax/tex.vim.gz
-- MARKDOWN-PREVIEW
vim.g.mkdp_auto_close = 0 -- Do not close preview window when changing buffer (Will close anyway when closing vim)
vim.g.mkdp_auto_start = 1 -- Start preview automatically when opening markdown file
vim.g.mkdp_port = '3415' -- Set port for preview, otherwise it would be chosen at random, which could potentially conflict
vim.g.mkdp_theme = 'dark' -- Set dark theme for markdown preview
-- LUA-SNIPPETS, see https://www.reddit.com/r/neovim/comments/tbtiy9/choice_nodes_in_luasnip/
ls = require("luasnip")
-- see alacritty config for the meaning of the character, or https://stackoverflow.com/questions/3336188/gvim-tab-key-doesnt-work:
-- vim.keymap.set({"i"}, "", function() ls.expand() end, {silent = true}) -- TODO: This seems to be unused
-- vim.keymap.set({"i", "s"}, "<C-o>", function() ls.jump( 1) end, {silent = true}) -- TODO: This seems to be unused
-- vim.keymap.set({"i", "s"}, "<C-e>", function() ls.jump(-1) end, {silent = true}) -- TODO: This seems to be unused
-- vim.keymap.set({"i", "s"}, "<C-E>", function() -- TODO: This seems to be unused
--     if ls.choice_active() then
--         ls.change_choice(1)
--     end
-- end, {silent = true})

-- Set up nvim-cmp: -- Hint: To limit width of suggestion and documentation window see https://github.com/hrsh7th/nvim-cmp/discussions/609
    local cmp = require'cmp'
    cmp.setup({
        snippet = {
            expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            -- ["<C-i>"] = cmp.mapping.select_prev_item(), -- previous suggestion -- see alacritty config for the meaning of the character, or link above
            -- The above mapping cannot work with the special character bound to ctrl i in alacritty, since nvim-cmp only checks for specific alphanumeric characters and certain ascii ones, see https://github.com/hrsh7th/nvim-cmp/pull/2073 and for a solution see code below, and also https://github.com/hrsh7th/nvim-cmp/issues/1849
            ["ႭჃႳ"] = cmp.mapping.select_prev_item(),
            ["<C-e>"] = cmp.mapping.select_next_item(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-n>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items, and to true to have to scroll through list to select something.
            ['<C-o>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items, and to true to have to scroll through list to select something.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' }, -- Primary source for coding completions
            { name = 'omni', group_index = 2 }, -- Use only if LSP lacks certain completions (e.g., VimTeX)
            { name = 'path', group_index = 2 }, -- Filepath completions
            { name = 'luasnip', group_index = 2 }, -- Useful if you use snippets
            --{ name = 'copilot', group_index = 3 }, -- Lower priority, or trigger manually
        }, {
            { name = 'buffer' },
        })
    })
-- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
            { name = 'buffer' },
        }, {
            { name = 'path' },
        })
    })
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline({
            -- The following mappings deviate in syntax from those in insert mode. This is necessary for it to work, but is considered to be a bug, see the link afterwards. If this gets fixed, adjust this to follow consistent syntax. Source: https://github.com/hrsh7th/nvim-cmp/issues/1835
            ["ႭჃႳ"] = { c = cmp.mapping.select_prev_item() },
            ["<C-e>"] = { c = cmp.mapping.select_next_item() },
            ["<C-n>"] = { c = cmp.mapping.abort() },
            ["<C-o>"] = { c = cmp.mapping.confirm() },

        }),
        sources = {
            { name = 'buffer' }
        }
    })
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
            -- The following mappings deviate in syntax from those in insert mode. This is necessary for it to work, but is considered to be a bug, see the link afterwards. If this gets fixed, adjust this to follow consistent syntax. Source: https://github.com/hrsh7th/nvim-cmp/issues/1835
            ["ႭჃႳ"] = { c = cmp.mapping.select_prev_item() },
            ["<C-e>"] = { c = cmp.mapping.select_next_item() },
            ["<C-n>"] = { c = cmp.mapping.abort() },
            ["<C-o>"] = { c = cmp.mapping.confirm() },
        }),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
require("cmp_git").setup()

-- Set up lspconfig. # TODO: Maybe use snippet https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
    on_attach = lsp_attach,
    capabilities = capabilities
}
require('lspconfig')['clangd'].setup {
    on_attach = lsp_attach,
    capabilities = capabilities
}
require('lspconfig')['fortls'].setup {
    on_attach = lsp_attach,
    capabilities = capabilities,
    root_dir = vim.fn.getcwd(),
}
vim.keymap.set('n', '<Leader>g', function() vim.cmd('terminal export EDITOR=nvr && export GIT_EDITOR="nvr --remote-wait" && gitu') end) -- stty sane prevents black screen until key input after gitu is closed --TODO: potentially improve this with https://danielrotter.at/2023/07/06/use-external-programs-like-git-in-Neovim-commands.html
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, { -- Source see https://vi.stackexchange.com/questions/3670/how-to-enter-insert-mode-when-entering-neovim-terminal-pane/3765#3765
    pattern = "term://*gitu",
    callback = function()
        vim.api.nvim_buf_del_keymap(0, 't', '<Esc>') -- Unmap <Esc> in terminal buffer so gitu can use it
        -- Force end buffer on closing terminal so message [Process exited 0] does not show after finishing gitu
        vim.api.nvim_create_autocmd("TermClose", {
            buffer = 0, -- Apply to the current buffer
            callback = function()
              vim.cmd("bd!") -- Close the buffer forcefully after the process exits
            end
          })
    end
})
-- Delete git buffer after quitting, so nvr --remote-wait finishes waiting, see autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "gitrebase", "gitconfig" },
    callback = function()
        vim.bo.bufhidden = "delete"
    end,
})
vim.api.nvim_create_autocmd("BufRead", { -- TODO this should not be necessary, this should be on by default, maybe defaults for gitcommit get overwritten somewhere
    pattern = "COMMIT_EDITMSG",
    callback = function()
        vim.cmd("set syntax=gitcommit")
    end,
})

-- LSP Line: -- TODO: Maybe use https://neovimcraft.com/plugin/rachartier/tiny-inline-diagnostic.nvim/ instead
-- require("lsp_lines").setup()
-- vim.diagnostic.config({
--   virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines.
--   virtual_lines = {
--     only_current_line = true,
--     highlight_whole_line = false,
--     wrap_long_lines = true, -- Wrap the line if it's still too long. -- TODO: This does not yet work, because this option is not yet merged into the release version of the plugin as of 2024-11-11. this will work in the future, and the whole plugin might go upstream to neovim, making this redundant, see https://lists.sr.ht/~whynothugo/lsp_lines.nvim/%3CD3FSJHV4IWFK.2P7DVELWNKS88@gpanders.com%3E
--   },
-- })

-- catppuccin overwrite black to be true black (source see https://github.com/nullchilly/CatNvim/blob/3ad12ec6f3e7a0408f04eb23a887286fe752a1a8/lua/plugins/colorscheme.lua#L27-L33):
require("catppuccin").setup {
    color_overrides = {
        -- all = {
        --     text = "#ffffff",
        -- },
        -- latte = {
        --     base = "#000000",
        --     mantle = "#000000",
        --     crust = "#000000",
        -- },
        -- frappe = {            
        --     base = "#000000",
        --     mantle = "#000000",
        --     crust = "#000000",
        -- },
        -- macchiato = {
        --     base = "#000000",
        --     mantle = "#000000",
        --     crust = "#000000",
        -- },
        -- mocha = {
        --     base = "#000000",
        --     mantle = "#000000",
        --     crust = "#000000",
        --
        -- },
    },
}
vim.cmd.colorscheme('catppuccin')
-- vim.cmd("AirlineTheme catppuccin") -- Set airline theme to catppuccin


-- Treesitter:
-- require'nvim-treesitter.configs'.setup {
--     textobjects = { enable = true,
--         select = {
--             enable = true,
--             lookahead = true,
--             keymaps = {
--                 -- You can use the capture groups defined in textobjects.scm
--                 ['af'] = '@function.outer',
--                 ['if'] = '@function.inner',
--                 ['ac'] = '@class.outer',
--                 ['ic'] = '@class.inner',
--             },
--         },
--         move = {
--             enable = true,
--             set_jumps = true, -- whether to set jumps in the jumplist
--             goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
--             goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
--             goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
--             goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
--         },
--         swap = {
--             enable = true,
--             swap_next = { ['<leader>>'] = '@parameter.inner' },
--             swap_previous = { ['<leader><'] = '@parameter.outer' },
--         },
--         lsp_interop = {
--             enable = true,
--             peek_definition_code = {
--                 ['gD'] = '@function.outer',
--             },
--         },
--     },
-- }
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "python", "lua", "fortran" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
            -- Disable for filetype latex, because vimtex highlighting better than treesitter, see https://blog.epheme.re/software/nvim-latex.html :
            if lang == 'latex' then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        enable = true,
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
            goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
            goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
            goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
        },
        swap = {
            enable = true,
            swap_next = { ['<leader>>'] = '@parameter.inner' },
            swap_previous = { ['<leader><'] = '@parameter.outer' },
        },
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ['gD'] = '@function.outer',
            },
        },
    },
    refactor = {
        navigation = {
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>",
            },
        },
    },
}
-- This seems to cause to much lag, see manual implementation below
-- require("autoclose").setup({
--     options = {
--         autoindent = false,
--     },
--     keys = {
--         ["$"] = { escape = true, close = true, pair = "$$", enabled_filetypes = {'tex'} },
--     },
-- })
-- Fix deindenting in latex files: -- TODO: This could be more elegantly done by editing the vimtex indentation guidelines to match my preferences
vim.g.vimtex_indent_enabled = 0
vim.opt.indentkeys:remove("}")
vim.opt.indentkeys:remove(")")
vim.opt.indentkeys:remove("]")

-- Templates -----------------------------
-- augroup templates
-- TODO: All of these below here seem to slow the loading of vim quite a bit, even more than just using vimscript commands (?):
--     LaTeX
    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.tex",
        callback = function()
            vim.api.nvim_put({ '\\documentclass{article}', '\\usepackage{eekhof}', '', '\\title{}', '\\begin{document}', '', 'CONTENT', '', '\\dobibliography', '\\end{document}', '% vim: wrap :' }, 'l', false, false) -- Insert template
            vim.api.nvim_win_set_cursor(0, { 4, 7 }) -- Go to position where the title is to be written
        end,
        group = templates
    })
--     Typst
    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.typ",
        callback = function()
            vim.api.nvim_put({ '#import "@local/eekhof:0.1.0": *', '#show: eekhof', '', '', '', '// vim: wrap :' }, 'l', false, false) -- Insert template
            vim.api.nvim_win_set_cursor(0, { 3, 1 }) -- Go to position where the title is to be written
        end,
        group = templates
    })
--     Markdown
    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.md",
        callback = function()
            vim.api.nvim_put({ '# TITLE' }, 'l', false, true) -- Insert template and follow cursor to position where title is to be written
            vim.o.conceallevel = 2 -- Conceal markdown syntax, enable link hiding since neovim v10+
        end,
        group = templates
    })
--     Shell script
    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.sh",
        callback = function()
            vim.api.nvim_put({ '#!/bin/sh', ''}, 'l', false, true) -- Insert template and follow cursor to position where code is to be written
        end,
        group = templates
    })
-- Groff
    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.ff",
        callback = function()
            vim.api.nvim_put({ '\\" vim: set wrap:','.TL','Titel','','.NH','Sectionheader', '.LP', 'Lorem ipsom dolor...', '', '.NH 2', 'Subsection heading', '.LP', 'Lorem ipsum dolor...'}, 'l', false, true) -- Insert template and follow cursor to position where code is to be written
        end,
        group = templates
    })
--     Start in insert mode at cursor position for any new file: -- TODO: This heavily slows down vim startup, so maybe remove it
    -- vim.api.nvim_create_autocmd("BufNewFile", {
    --     callback = function()
    --         -- vim.api.nvim_input('i') -- Enter insert mode--TODO: Maybe use vim.api.nvim_feedkeys , see below
    --         vim.cmd('startinsert') -- Enter insert mode-- TODO: Also isnt faster
    --         -- vim.api.nvim_feedkeys('i', 'm', true) -- Enter insert mode with feedkey, does not result in noticable change in https://neovim.io/doc/user/api.html#nvim_feedkeys()
    --     end,
    --     group = templates
    -- })

-- LSP Config hotkeys (See https://blog.epheme.re/software/nvim-latex.html):
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
--vim.api.nvim_create_autocmd("LspAttach", {
--    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--    callback = function(ev)
--        -- Enable completion triggered by <c-x><c-o>
--        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--
--        -- Buffer local mappings.
--        -- See `:help vim.lsp.*` for documentation on any of the below functions
--        local opts = { buffer = ev.buf }
--        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--        vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
--        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--    end,
--})
-- TODO: Clean up mappings on LSP-Detach, see https://neovim.io/doc/user/lsp.html#LspDetach


-- Filetype recognition -----------------------------
-- Set the filetype groff based on the file's extension, overriding any 'ff' that has already been set (Source: https://stackoverflow.com/questions/11666170/persistent-set-syntax-for-a-given-filetype/28117335#28117335)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.ff",
    callback = function()
        vim.api.nvim_buf_set_option(0, 'filetype', 'groff')
    end,
    group = filetype
})
-- Autocommand for common Mesa config files in Fortran
vim.cmd[[
augroup FortranFiletype
    autocmd!
    autocmd BufRead,BufNewFile inlist*,history_columns.list,profile_columns.list,gyre.in set filetype=fortran | set syntax=fortran
augroup END
]]

-- Statusline etc. -----------------------------
vim.o.statusline = ''
-- vim.o.statusline = vim.o.statusline .. '%f'                        -- File name with relative path (e. g. only filename if in cwd)
vim.o.statusline = vim.o.statusline .. '%F'                        -- File name with full path
vim.o.statusline = vim.o.statusline .. ' %= '    -- Switch to the right side
vim.o.statusline = vim.o.statusline .. 'Ln: %3l/%L    ' -- Lines out of total lines
vim.o.statusline = vim.o.statusline .. 'Col: %-3c    ' -- Current column
vim.o.statusline = vim.o.statusline .. '(%-3p%%)    ' -- Percentage through file

vim.o.title = true                              -- Show title in window
vim.o.titlestring = 'NVim: %F %a%r%m' -- Title of the window-- TODO: Originally, 'titlelen=70' was appended to the line, but this did get printed out literally, so it was removed, see source https://medium.com/usevim/changing-vims-title-713001d4049c

-- TODOs -----------------------------
-- TODO: Pyright does work, but pyright- command line commands do not work yet
-- TODO: Focus on Vim after inverse search (Solution from source https://www.ejmastnak.com/tutorials/vim-latex/pdf-reader/#refocus-gvim did not work)
-- TODO: Set up zathura to start with frame fit to width
-- TODO: Set up VimTex to start in splitscreen with zathura on the right
-- TODO: Set up Jupyter Notebook support
-- TODO: Do HTML-Commands work yet?
-- TODO: Add error highlighting in LaTeX
-- TODO: Add jump to error via clicking link in quickfix for LaTeX
-- TODO: When putting a closing bracket behind an indented line, the line sometimes gets unindented
-- TODO: Insert functionality that when using e. g. "da(" while not inside brackets, it just applies the operation to the next bracket
-- TODO: Make f F t and T and also ;, work on multiple lines (Possible Source: https://stackoverflow.com/questions/3925230/using-vims-f-command-over-multiple-lines/10564049#10564049 but this causes repetition like 3fx to not work anymore)
-- TODO: Add custom latex package to snippets. It seems this can be done straight with the VSCode-Snipped file that the eekhof-plugin-installer generates anyway, as "Friendly-Snippets" makes use of such files too.
-- TODO: The issue where neovim freezes on pasting the clipboard is due to a bug in XClip, see https://www.reddit.com/r/neovim/comments/r7h538/clipboard_error_error_target_string_not_available/ and https://github.com/astrand/xclip/issues/38
-- TODO: After compiling (leader+ll) vimtex periodically flickers the cursor when in insert mode, probably because of periodic recompiling of the pdf, disable the flicker. This does not occur when using single shot :VimtexCompileSS as opposed to the usual :VimtexCompile , see https://ejmastnak.com/tutorials/vim-latex/compilation/
-- TODO: The behavior of gitu commits is still inconsistent, if a commit window from nvim is closed with wq the commit does not happen, if gitu is opened from the terminal and closed with wq it does happen
-- TODO: Snippets are now native neovim feature, use them instead of luasnips, see https://github.com/neovim/neovim/pull/25301
-- TODO: Treesitter is native neovim feature, check if it is used instead of other treesitter plugin
-- TODO: Latex compile alias COMPILETEX for w does also apply to bib files, and possibly other files opened in the same buffer
-- TODO: For the latex errors, make it so that only fatal compilation breaking errors are shown as red E errors on the left bar, missing refereces are shown as yellow W warnings and under/overfull is shown as green H hint

-- Uninstall -----------------------------
-- To uninstall this script and all changes made by it, delete '~/.config/nvim' and ... -- TODO: Add location where plugins are installed by lazy.nvim
