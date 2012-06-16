alias rm='rm -i'
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -hlF'
alias lll='ll -a'
alias sh='bash'
alias vi='vii'
alias xcd='. xcd.sh'
alias sudo='sudo -E'
alias screen='screen -d -r||screen'
PS1='\[\033[0;31m\]\u\[\033[0;35m\]@\h:\[\e[33m\]\w\[\e[0m\]\n> '
PATH=$PATH:~/bin:~/my/bin:~/opt/bin
source ~/bin/langrc
export NODE_PATH=.:./node_modules/:~/opt/lib/node_modules/
