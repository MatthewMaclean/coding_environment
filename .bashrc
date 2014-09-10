# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

if [ "$(uname)" == "Darwin" ]
then
    alias ls="ls -a -G"
else
    eval `dircolors ~/.dir_colors`
    alias ls="ls -a --color"
fi
