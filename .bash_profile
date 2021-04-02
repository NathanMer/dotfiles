source ~/.profile
PS1="\[$(tput setaf 5)\][\u \W]\\$ \[$(tput sgr0)\]\[$(tput sgr0)\]"

export PATH="/usr/local/opt/python/libexec/bin:/usr/local/sbin:$PATH"

export VISUAL=vim
export EDITOR="$VISUAL"

export CLICOLOR=1

export FIGNORE=$FIGNORE:DS_Store

export PATH="$HOME/.cargo/bin:$PATH"

alias sshpkd="ssh nmerrill@pkd.physics.haverford.edu"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
