# CUSTOM SCRIPTS BY LUCAS EEKHOF

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd #cd to dir by typing dirname see luke smith bashrc

# SCRIPT FOR PROMPT COLORING
# If id command returns zero, you got root access.
if [ $(id -u) -eq 0 ]
then # you are root, set red colour prompt (Only for true root login, not for su-command-environment)
PS1="\\[\e[1;31m\\][\u@\h \\[\e[m\\]\W\\[\e[1;31m\\]]# \\[\e[m\\]"
else # normal
PS1="\\[\e[1;32m\\][\u@\h \\[\e[m\\]\W\\[\e[1;32m\\]]$ \\[\e[m\\]"
fi
# DEFINE COLORED ls AS DEFAULT, AND DISPLAY HIDDEN FILES PER DEFAULT
alias ls='ls -a --color=auto'
# DEFINE grep AND diff COMMANDS TO USE COLORS PER DEFAULT
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Define command to enter note-taking-workflow
alias n='nvim ~/Sonstiges/notes'
# Define command to open todo file
alias todo='nvim ~/Sonstiges/todo_liste_allgemein.txt'

# Further aliases
alias nvim='nvim -p' # -p is to open files in tabs
alias vi='nvim -p'
alias vim='nvim -p'
alias nv='nvim -p'
alias v='nvim -p'
alias snvim='sudo -E nvim -p' # -E to edit file with sudo priviliges while using custom vim config of user
alias svi='sudo -E nvim -p'
alias svim='sudo -E nvim -p'
alias snv='sudo -E nvim -p'
alias sv='sudo -E nvim -p'
# Without using undofile, for this option see init.lua:
alias anonnvim='nvim -p -c "set noundofile"'
alias anonvi='nvim -p -c "set noundofile"'
alias anonvim='nvim -p -c "set noundofile"'
alias anonnv='nvim -p -c "set noundofile"'
alias anonv='nvim -p -c "set noundofile"'
alias anonsnvim='sudo -E nvim -p -c "set noundofile"'
alias anonsvi='sudo -E nvim -p -c "set noundofile"'
alias anonsvim='sudo -E nvim -p -c "set noundofile"'
alias anonsnv='sudo -E nvim -p -c "set noundofile"'
alias anonsv='sudo -E nvim -p -c "set noundofile"'

alias ff='f(){ groff -ms -dpaper=a4 -Kutf8 "$@" -T pdf > "${@%.*}".pdf; unset -f f; }; f' # To compile groff documents
alias topdf='f(){ convert ${*%${!#}} -quality 00 -auto-orient ${@:$#}.pdf; unset -f f; }; f' # To convert images to pdf with imagemagick (First put all input files in right order, the last argument will be the name of the pdf-file, but must not include file ending) # TODO Quality is still not optimal, potentiall use setting "-quality 100" or "-density 300"

set -o vi # Enable bash mode mode to use vim keybindings
bind '"jk":vi-movement-mode' # Use jk to exit normal vim mode in bash and go back to insert mode, see https://unix.stackexchange.com/questions/74075/custom-key-bindings-for-vi-shell-mode-ie-set-o-vi/74079#74079
# Add some handy emacs-bindings for bash terminal eventhough vi mode is activated:
bind '"\C-k":kill-line' # Use CTRL+k to kill rest of line behind cursor
bind '"\C-a":beginning-of-line' # Use CTRL+k to kill rest of line behind cursor
bind '"\C-e":end-of-line' # Use CTRL+k to kill rest of line behind cursor
export EDITOR=nvim # Set default editor to NeoVim

# Make CTRL+S scroll forward through matching history, because CTRL#R searches backward (Source: https://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r/791800#791800)
[[ $- == *i* ]] && stty -ixon
# Key bindings, up/down arrow searches through history, using bind to avoid having to use inputrc (Source: https://unix.stackexchange.com/questions/5366/command-line-completion-from-command-history/20830#20830)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'

# CONTROL FLAG TO IGNORE COMMANDS WITH LEADING SPACES FROM HISTORY
HISTCONTROL=ignorespace

# SET HISTORY SIZE
HISTSIZE=5000 # Number of commands to log in one terminal session
HISTFILESIZE=5000 # Number of commands to log in histfile after terminal session is closed

# Read in path for custom binaries
export PATH="$HOME/.bin:$PATH"
# TODO Why is the following line needed?:
PATH=/home/lucas/.bin:/home/lucas/.bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/home/lucas/.dotnet/tools:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/lucas/.local/bin

# Change paths to conform to XDG Base Directory Specification: # TODO: Does not work yet
# export XDG_CONFIG_HOME=$HOME/.config
# export XDG_CACHE_HOME=$HOME/.cache
# export GNUPGHOME=${XDG_CONFIG_HOME}/gnupg # See https://superuser.com/questions/874901/what-are-the-step-to-move-all-your-dotfiles-into-xdg-directories
# export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority # see https://wiki.archlinux.org/title/XDG_Base_Directory#Partial
