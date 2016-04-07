#!/bin/sh

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

cat >> ~/.bashrc << EOF

# git branch on bash prompt
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='[\\u@\\h \\w]\\e[1;35m\$(__git_ps1)\\e[m# '
EOF

source ~/.bashrc
