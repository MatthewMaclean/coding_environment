# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

eval `dircolors ~/.dir_colors`

alias ls="ls -a --color"
