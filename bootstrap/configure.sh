#!/bin/bash

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Python packages
pip install poetry virtualenv virtualenvwrapper

echo "Updating package lists..."
brew update

echo "Installing bonclay to manage dotfiles..."
brew install talal/tap/bonclay

echo "Installing drone cli"
brew tap drone/drone
brew install drone

echo "Installing java..."
brew cask install adoptopenjdk

echo "Installing packages..."
brew install ack \
    autoconf \
    awscli \
    cfssl \
    cloc \
    ctags \
    ctop \
    ffmpeg \
    flac \
    fzf \
    gcc \
    gdbm \
    gettext \
    git \
    bash-completion \
    glib \
    gmp \
    gnupg \
    gnutls \
    go \
    htop \
    jq \
    kubectx \
    kubernetes-cli \
    kubernetes-helm \
    libevent \
    libffi \
    libgpg-error \
    mitmproxy \
    ncurses \
    nmap \
    node \
    openssl \
    pyenv \
    pyenv-virtualenv \
    pyenv-virtualenvwrapper \
    python \
    readline \
    speedtest-cli \
    sqlite \
    stern \
    syncthing \
    tmux \
    tree \
    vim \
    watchman \
    zsh \
    zsh-completions


# oh-my-zsh install
echo ''
echo "Now installing oh-my-zsh..."
echo ''
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh plugin install
mkdir $ZSH/plugins/poetry
poetry completions zsh > $ZSH/plugins/poetry/_poetry
# echo ''
# echo "Now installing oh-my-zsh plugins..."
# echo ''
# git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
# git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# powerlevel9k install
echo ''
echo "Now installing powerlevel9k..."
echo ''
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# vimrc vundle install
echo ''
echo "Now installing vundle..."
echo ''
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Pull down personal dotfiles
echo ''
echo "Now pulling down your dotfiles..."
git clone https://github.com/$USER/dotfiles.git ~/.dotfiles
echo ''
cd $HOME/.dotfiles && echo "switched to .dotfiles dir..."
echo 'Syncing dotfiles with bonclay...'
bonclay sync bonclay.conf.yaml
echo "Successfully configured your environment with dotfiles..."

echo "Now setting default shell..."
chsh -s $(which zsh); exit 0
if [[ $? -eq 0 ]] then
    echo "Successfully set your default shell to zsh..."
else
    echo "Default shell not set successfully..." >&2
fi


echo 'Installing Vundle plugins...'
vim +PluginInstall +qall
. ~/.zshrc
echo '	Badass macOS terminal installed!'