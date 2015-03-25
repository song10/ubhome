# This loads NVM
[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh
type nvm >& /dev/null && nvm use stable

tabs -2

alias rm='rm -i'
alias ls='ls --color=auto --group-directories-first'
alias l='ls'
alias ll='ls -hlF'
alias lll='ll -a'
alias sh='bash'
alias vi='vii'
alias xcd='. xcd.sh'
alias ycd='. ycd.sh'
alias sudo='DBUS_SESSION_BUS_ADDRESS= sudo -E'
alias screen='screen -d -r||screen'
alias cd1='cd ..'
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias cd5='cd ../../../../..'
alias scr='screen -D -R'
alias nd='node --harmony'

#PS1='\[\e]0;\u@\h:\w\a\]\[\033[0;31m\]\u\[\033[0;35m\]@\h:\[\e[33m\]\w\[\e[0m\]\n> '
PS1='\[\033[0;31m\]\u\[\033[0;35m\]@\h:\[\e[33m\]\w\[\e[0m\]\n> '
PATH=$PATH:~/bin:~/opt/bin:~/my/bin:~/my/opt/bin:~/tmp/rakudo/install/bin:$PATH
source ~/bin/langrc
export NODE_PATH=.:./local_modules:./node_modules/:/usr/local/lib/node_modules/:/usr/lib/node_modules:/usr/local/share/npm/lib/node_modules:$NODE_PATH
export EDITOR=vi
export APP=~/my/app
export NODE_PATH=$NODE_PATH:~/.nvm/versions/node/v0.12.0/lib/node_modules

export LANGUAGE="en"
export LANG="C"
export LC_MESSAGES="C"
export LC_ALL=en_US.UTF-8

function tabtitle {
  echo -en "\033]2;$1\007"
}

function scrtitle {
  echo -en '\033k'$1'\033\\'
}

rm -f ~/.goutputstream-*
rm -f ~/.Xauthority.*
rm -f ~/libpeerconnection.log

uname -a | grep -i darwin 2>&1 >/dev/null && if [ -f ~/.bash_osx ]; then . ~/.bash_osx; fi

x=$(env|grep DISPLAY) && tabtitle $HOSTNAME
cd ~
