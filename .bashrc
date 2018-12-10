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

alias gd="./godelw"

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home"

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

function lock_update () {
    ./gradlew generateLock saveLock idea;
}

function conjure_compile () {
    ./gradlew compileConjureJavaServer compileConjureTypescriptClient;
}

function replace_recursive () {
    find .  \( -name '.git' \) -prune -o -type f -print0 | xargs -0 sed -i '' -e 's/'$1'/'$2'/g'
}

function stop_docker () {
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
}

function changelog_version () {
    git log --pretty=tformat:%s $1.. | sed 's/^/- /' | pbcopy
}

function changelog () {
    git log --pretty=tformat:%s $(git describe --tags --abbrev=0 @^).. | sed 's/^/- /' | pbcopy
}

function json () {
    while read i; do echo $i | python -m json.tool ; done < $1
}

function largest_files {
    du -a /opt | sort -n -r | head -n 10
}

# resize lossy delay
# e.g. to_gif 40% 150 10
function to_gif () {
    # remove any existing gifs in the directory
    rm *.gif
    # resize and jpgs to gifs
    mogrify -resize $1 -auto-orient -format gif *.jpg *.JPG
    # combine to a gif
    #   delay is in milliseconds
    gifsicle -O2 --lossy=$2 --delay=$3 --loop *.gif > output.gif
}

export PS1="\w \$"
alias vim='/usr/local/Cellar/vim/8.0.0596/bin/vim'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GO="/Volumes/git/go/src/github.palantir.build/deployability"

function ahead_behind {
    curr_branch=$(git rev-parse --abbrev-ref HEAD);
    curr_remote=$(git config branch.$curr_branch.remote);
    curr_merge_branch=$(git config branch.$curr_branch.merge | cut -d / -f 3);
    git rev-list --left-right --count $curr_branch...$curr_remote/$curr_merge_branch | tr -s '\t' '|';
}
