# git branch on bash prompt
# https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
source /usr/local/bin/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
#export PS1='[\u@\h \w]$(__git_ps1)# '
export PS1='[\[\e[1;34m\]\u@\h \[\e[1;32m\]\w\[\e[m\]]\[\e[1;35m\]$(__git_ps1)\[\e[m\]# '
