# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Python3 in PATH
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/$USER/.oh-my-zsh"

# For compilers to find libffi you may need to set:
# export LDFLAGS="-L/usr/local/opt/libffi/lib"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    tmux
    bundler
    poetry
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# OTHER
export GREP_COLORS='00;38;5;226'

# RUST
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH=/Users/$USER/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
export RUST_BACKTRACE=1

# DOCKER
alias dc='docker-compose'
alias grep="grep --color=auto"
alias docker-rm-untagged='docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")'
alias docker-rm-dangling='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-rm-exited='docker rm $(docker ps -a -q -f status=exited) -v'
alias dockerclean="docker container prune -f && docker image prune -f && docker volume prune -f"
alias pyclean='find . | grep -E "(__pycache__|.pyc|.pyo$)" | xargs rm -rf'

# git
alias githeat='git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10'

# github
export GITHUB_PR_TOKEN='974717ba22a64bba439499caf3e722e19fc4893c'
# AWS CLI
alias lambdanames='aws lambda list-functions | jq ".Functions | .[].FunctionName" | fzf'
alias k='kubectl'
alias mk='minikube'
alias wk='workon'
# FUZZYSEARCH
fpath=(
    ~/.zfunc
    "${fpath[@]}"
)
fpath+=~/.zfunc
compinit
autoload -Uz fe fd fda cdf fh ftpane fbook fshow fshowp fcoc fcoc_preview fbr ripgrep stats fri rmerge compinite rmerged

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# VIRTUALENVWRAPPER
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

# Java
export JAVA_HOME=/"Library/Java/JavaVirtualMachines/openjdk-12.0.1.jdk/Contents/Home"

# eval "$(jenv init -)"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export DRONE_SERVER=https://drone.domain.com
export DRONE_TOKEN=''

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/$USER/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/$USER/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/$USER/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/$USER/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

export AWS_DEFAULT_PROFILE=''

source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
