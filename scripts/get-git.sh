#!/bin/sh

yum install -y git

cat > ~/.gitconfig << EOF
[push]
    default = simple
[user]
    name = Guoqiang Chen
    email = subchen@gmail.com
[color]
    ui = true
EOF

curl -fSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o /usr/bin/.git-prompt.sh

cat > /etc/profile.d/git-env.sh << EOF
. /usr/bin/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='[\\u@\\h \\w]\\e[1;35m\$(__git_ps1)\\e[m# '
EOF

. /etc/profile.d/git-env.sh
