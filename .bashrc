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
fi

function gitclean() {
    git branch --merged | grep -v "\*" | grep -v "master" | grep -v "develop" | xargs -n 1 git branch -d
}

function scpp () {
    scp $1 $2:
    ssh -t $2 'chmod a+r '$1'; sudo -u palantir cp '$1' /home/palantir/'
}

function deploy() {
    #scp $1 $2:
    ssh -t $2 'chmod a+r '$1'; export PATH=$PATH:/opt/palantir/skylab/deployctl/service/bin/linux-amd64; sudo -u palantir cp '$1' /home/palantir/; sudo -u palantir env "PATH=$PATH" deployctl product import /home/palantir/'$1'; sudo -u palantir rm /home/palantir/'$1
}

function sshp () {
    ssh -t $1 "sudo su - palantir"
}

function replace_recursive () {
    find .  \( -name '.git' \) -prune -o -type f -print0 | xargs -0 sed -i '' -e 's/'$1'/'$2'/g'
}

function stop_docker () {
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
}

export PS1="\w \$"
