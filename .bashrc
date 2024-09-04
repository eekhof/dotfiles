# CUSTOM SCRIPTS BY LUCAS EEKHOF

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

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
# To start neovim server on startup do "nvr -s" (starts a new nvim process with the server address set to /tmp/nvimsocket), all the following processes will attach to it with nvr --remote
# export EDITOR="nvr -s" # Set default editor to nvr in order for processes started from the NeoVim Terminal to always send their output to the parent nvim instance
export EDITOR="nvim" # Set default editor to nvim
# alias nvim="nvr -s"
alias vi='nvim'
alias vim='nvim'
alias nv='nvim'
alias v='nvim'
alias snvim='sudo -E nvim' # -E to edit file with sudo priviliges while using custom vim config of user
alias svi='sudo -E nvim'
alias svim='sudo -E nvim'
alias snv='sudo -E nvim'
alias sv='sudo -E nvim'
# Without using undofile, for this option see init.lua:
alias anonnvim='nvim -c "set noundofile"'
alias anonvi='nvim -c "set noundofile"'
alias anonvim='nvim -c "set noundofile"'
alias anonnv='nvim -c "set noundofile"'
alias anonv='nvim -c "set noundofile"'
alias anonsnvim='sudo -E nvim -c "set noundofile"'
alias anonsvi='sudo -E nvim -c "set noundofile"'
alias anonsvim='sudo -E nvim -c "set noundofile"'
alias anonsnv='sudo -E nvim -c "set noundofile"'
alias anonsv='sudo -E nvim -c "set noundofile"'

alias ff='f(){ groff -ms -dpaper=a4 -Kutf8 "$@" -T pdf > "${@%.*}".pdf; unset -f f; }; f' # To compile groff documents
alias topdf='f(){ convert ${*%${!#}} -quality 00 -auto-orient ${@:$#}.pdf; unset -f f; }; f' # To convert images to pdf with imagemagick (First put all input files in right order, the last argument will be the name of the pdf-file, but must not include file ending) # TODO Quality is still not optimal, potentiall use setting "-quality 100" or "-density 300"

alias colemak='sudo setxkbmap us -variant colemak_dh_iso "grp:alt_shift_toggle, compose:rwin" && xmodmap -e "keycode 105 = dead_greek dead_greek dead_greek dead_greek"' # set dead greek key see [StackOverflow](https://superuser.com/a/1229239) and determine right keykode with "xev | grep keycode", e. g. "105" for Right-CTRL-Key
alias qwerty='setxkbmap "us, de" pc105 ", nodeadkeys" "grp:alt_shift_toggle, compose:rwin" && xmodmap -e "keycode 105 = dead_greek dead_greek dead_greek dead_greek"'
alias qwertz='setxkbmap "de, us" pc105 "nodeadkeys, " "grp:alt_shift_toggle, compose:rwin" && xmodmap -e "keycode 105 = dead_greek dead_greek dead_greek dead_greek"'

# Make ranger open at last opened directory (see https://superuser.com/questions/1043806/how-to-exit-the-ranger-file-explorer-back-to-command-prompt-but-keep-the-current#comment2246278_1329678):
alias ranger='. ranger'

# Function to set all connected monitors to the same resolution
function screenmirror() {
    # Function to get the highest resolution of the lowest quality monitor, so all connected monitors can show the full image
    get_lowest_max_resolution() {
        # Extract monitor names and their highest available resolution
        xrandr | grep -A1 " connected" | grep -P '^\s+\d+x\d+' | awk '{print $1}' | \
        while read -r resolution; do
            echo $resolution
        done | sort -n | head -n 1
    }

    # Check if a resolution argument is provided, set to lowest max resolution otherwise
    if [ -z "$1" ]
    then
        RESOLUTION=$(get_lowest_max_resolution)
    else
        RESOLUTION=$1
    fi

    # Apply resolution to all connected monitors
    xrandr --listmonitors | sed -n '1!p' | sed -e 's/.*\s\([a-zA-Z0-9\-]*\)$/\1/g' | \
    xargs -n 1 bash -c 'xrandr --output "$0" --mode '"$RESOLUTION"' --pos 0x0 --rotate normal'

    echo "All connected monitors set to mirror at resolution $RESOLUTION"
}

# Helper function to get the name of connected monitors, where n is the first argument
get_connected_monitors() {
    while read p; do
        connected_monitors+=("$p")
    done < <(xrandr | grep " connected")
    connected_monitors=("${connected_monitors[@]%% *}")
}

function screenextend () {
    # Function to get the maximum resolution of a monitor, where the first argument is the monitor name
    get_monitor_max_resolution() {
        xrandr | grep -A1 "$1" | grep -P '^\s+\d+x\d+' | awk '{print $1}' | \
            while read -r resolution; do
                echo $resolution
            done | sort -n | tail -n 1
    }

    # Set arguments
    get_connected_monitors # this sets the connected_monitors array
    OUTPUT1=${1:-${connected_monitors[0]}}
    OUTPUT2=${2:-${connected_monitors[1]}}
    RESOLUTION1=${3:-$(get_monitor_max_resolution $OUTPUT1)}
    RESOLUTION2=${4:-$(get_monitor_max_resolution $OUTPUT2)}

    # Execute xrandr command
    xrandr --output "$OUTPUT1" --mode "$RESOLUTION1" --primary --output "$OUTPUT2" --mode "$RESOLUTION2" --right-of "$OUTPUT1"
    echo "Connected monitors $OUTPUT1 and $OUTPUT2 set to extend with resolutions $RESOLUTION1 and $RESOLUTION2"
}

screentablet() {
    # Set the tablet to the right of the primary monitor
    TABLETID=$(xinput | grep -oP 'Huion Tablet Pen Pen.*\tid=\K[0-9]+') # the (0) in the tablet name was left out because it causes problems with the grep command
    get_connected_monitors
    OUTPUT=${1:-${connected_monitors[0]}}
    xinput map-to-output "$TABLETID" "$OUTPUT"
    echo "Set tablet $TABLETID to output $OUTPUT"
}

# set -o vi # Enable bash mode mode to use vim keybindings
bind '"jk":vi-movement-mode' # Use jk to exit normal vim mode in bash and go back to insert mode, see https://unix.stackexchange.com/questions/74075/custom-key-bindings-for-vi-shell-mode-ie-set-o-vi/74079#74079
# Add some handy emacs-bindings for bash terminal eventhough vi mode is activated:
bind '"\C-k":kill-line' # Use CTRL+k to kill rest of line behind cursor
bind '"\C-a":beginning-of-line' # Use CTRL+k to kill rest of line behind cursor
bind '"\C-e":end-of-line' # Use CTRL+k to kill rest of line behind cursor

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
PATH=$HOME/.bin:/home/lucas/.bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/home/lucas/.dotnet/tools:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/lucas/.local/bin

# Add TexLive binaries path to path:
PATH=/usr/local/texlive/2024/bin/x86_64-linux/:$PATH
# Add rust cargo installed bin folder to path:
PATH=$HOME/.cargo/bin:$PATH

# Change paths to conform to XDG Base Directory Specification: # TODO: Does not work yet
# export XDG_CONFIG_HOME=$HOME/.config
# export XDG_CACHE_HOME=$HOME/.cache
# export GNUPGHOME=${XDG_CONFIG_HOME}/gnupg # See https://superuser.com/questions/874901/what-are-the-step-to-move-all-your-dotfiles-into-xdg-directories
# export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority # see https://wiki.archlinux.org/title/XDG_Base_Directory#Partial
