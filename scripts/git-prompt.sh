#!/bin.sh

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

cat >> ~/.bashrc << EOF
source ~/.git-prompt.sh

MAGENTA_COLOR=$'\e[1;35m'
NORMAL_COLOR=$'\e[m'
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='[\u@\h \w]$MAGENTA_COLOR$(__git_ps1)$NORMAL_COLOR# '
EOF

source ~/.bashrc
