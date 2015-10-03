#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1="\[$(tput setaf 5)\][\u@\h \W]\\$ \[$(tput sgr0)\]\[$(tput sgr0)\]"

d=dircolors.ansi-dark
test -r $d && eval "$(dircolors $d)"
