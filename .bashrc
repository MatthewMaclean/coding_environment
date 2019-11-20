# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

if [ "$(uname)" == "Darwin" ]
then
    alias ls="ls -a -G"
    export LC_CTYPE=C
    export LANG=C
else
    eval `dircolors ~/.dir_colors`
    alias ls="ls -a --color"
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

export PS1="\w \$"

alias brs="git for-each-ref --sort=committerdate refs/heads/ --format='%(color: red)%(committerdate:short) %(color: cyan)%(refname:short)'"
