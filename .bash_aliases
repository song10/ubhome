[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM
type nvm >& /dev/null && nvm use v0.10.26

tabs -2

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
alias cd1='cd ..'
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias cd5='cd ../../../../..'
alias scr='screen -D -R'
#PS1='\[\e]0;\u@\h:\w\a\]\[\033[0;31m\]\u\[\033[0;35m\]@\h:\[\e[33m\]\w\[\e[0m\]\n> '
PS1='\[\033[0;31m\]\u\[\033[0;35m\]@\h:\[\e[33m\]\w\[\e[0m\]\n> '
PATH=~/bin:~/my/bin:~/opt/bin:~/tmp/rakudo/install/bin:$PATH
source ~/bin/langrc
export NODE_PATH=.:./node_modules/:/usr/local/lib/node_modules/:/usr/lib/node_modules:/usr/local/share/npm/lib/node_modules:$NODE_PATH
export EDITOR=vi
export APP=~/my/app

function tabtitle {
  echo -en "\033]2;$1\007"
}

function scrtitle {
  echo -en '\033k'$1'\033\\'
}

rm -f ~/.goutputstream-*
rm -f ~/.Xauthority.*
rm -f ~/libpeerconnection.log

if [ -f ~/.bash_insyde ]; then . ~/.bash_insyde; fi
if [ -f ~/.bash_android ]; then . ~/.bash_android; fi

uname -a | grep -i darwin 2>&1 >/dev/null && if [ -f ~/.bash_osx ]; then . ~/.bash_osx; fi

x=$(env|grep DISPLAY) && tabtitle $HOSTNAME
cd ~
