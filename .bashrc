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

# Source modular shell configuration
for f in ~/.paths ~/.functions; do
  [ -f "$f" ] && . "$f"
done
