alias rm='rm -i'
alias ls='ls --color=auto --group-directories-first'
alias l='ls'
alias ll='ls -hlF'
alias lll='ll -a'
alias sh='bash'
alias vi='vii'
alias xcd='. xcd.sh'
alias sudo='DBUS_SESSION_BUS_ADDRESS= sudo -E'
alias screen='screen -d -r||screen'
alias ssh='ssh -X'
alias cd1='cd ..'
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias cd5='cd ../../../../..'
alias scr='screen -D -R'
#PS1='\[\e]0;\u@\h:\w\a\]\[\033[0;31m\]\u\[\033[0;35m\]@\h:\[\e[33m\]\w\[\e[0m\]\n> '
PS1='\[\033[0;31m\]\u\[\033[0;35m\]@\h:\[\e[33m\]\w\[\e[0m\]\n> '
PATH=~/bin:~/my/bin:~/opt/bin:$PATH
source ~/bin/langrc
export NODE_PATH=.:./node_modules/:~/opt/lib/node_modules/
export EDITOR=vi

function tabtitle {
  echo -en "\033]2;$1\007"
}

function scrtitle {
  echo -en '\033k'$1'\033\\'
}

if [ -f ~/.bash_insyde ]; then
    . ~/.bash_insyde
fi

rm -f ~/.goutputstream-*

x=$(env|grep DISPLAY) && tabtitle $HOSTNAME
cd ~
