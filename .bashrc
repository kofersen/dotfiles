#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -lat --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# GPG needs to know the active TTY
export GPG_TTY="$(tty)"

# Load PATH definitions
[ -f "$HOME/.paths" ] && source "$HOME/.paths"

# Load shortcuts definitions (for the sake of QoL)
[ -f "$HOME/.shortcuts" ] && source "$HOME/.shortcuts"
