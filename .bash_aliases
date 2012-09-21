alias rm='rm -i'
alias ls='ls --color=auto --group-directories-first'
alias l='ls'
alias ll='ls -hlF'
alias lll='ll -a'
alias sh='bash'
alias vi='vii'
alias xcd='. xcd.sh'
alias sudo='sudo -E'
alias screen='screen -d -r||screen'
alias ssh='ssh -X'
alias cd1='cd ..'
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias cd5='cd ../../../../..'
PS1='\[\033[0;31m\]\u\[\033[0;35m\]@\h:\[\e[33m\]\w\[\e[0m\]\n> '
PATH=$PATH:~/bin:~/my/bin:~/opt/bin
source ~/bin/langrc
export NODE_PATH=.:./node_modules/:~/opt/lib/node_modules/

export JAVA_HOME=~/Downloads/jdk1.7.0_07
export PATH=$JAVA_HOME/bin:$PATH
#export UBUNTU_MENUPROXY=libappmenu.so
export EDITOR=vi

if [ -f ~/.bash_insyde ]; then
    . ~/.bash_insyde
fi

rm -f ~/.goutputstream-*
