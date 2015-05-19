for i in ~/.bashrc.d/*.sh ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then
            . "$i"
        else
            . "$i" >/dev/null
        fi
    fi
done

alias ll="ls -la --color"
alias more="less"
alias grep="grep -n"
alias vi="vim"

# export PS1="\e[0;35m\w$ \e[m"
export TZ=CST-8
