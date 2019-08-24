#!/bin/bash

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Updating package lists..."
brew update

echo "Installing bonclay to manage dotfiles..."
brew install talal/tap/bonclay

echo "Installing drone cli"
brew tap drone/drone
brew install drone

echo "Installing java..."
brew cask install adoptopenjdk

echo "Installing AWS cli..."
brew install awscli

# Python has been installed as a dependency of awscli.
echo "Installing virtualenv tools for Python..."
pip virtualenv virtualenvwrapper powerline-status


echo "Installing packages..."
brew install ack \
    autoconf \
    cfssl \
    cloc \
    ctags \
    ctop \
    fzf \
    gcc \
    gdbm \
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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

# python poetry
pip install poetry

# oh-my-zsh plugin install
mkdir $ZSH/plugins/poetry
poetry completions zsh > $ZSH/plugins/poetry/_poetry
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

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

# Pure power install
echo ''
echo "Now installing Pure Power terminal theme..."
echo ''
cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower
echo 'source ~/.purepower' >>! ~/.zshrc
git clone https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k

echo 'Installing Vundle plugins...'
vim -c 'PluginInstall' -c 'qa!'

echo "Curling terminal theme"
curl https://raw.githubusercontent.com/lysyi3m/macos-terminal-themes/master/schemes/Cobalt2.terminal -o ~/Cobalt2.terminal

echo ''
read -p "Do you want to download docker and sublime? y/n" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ''
    echo "Curling Docker for mac..."
    curl https://download.docker.com/mac/stable/Docker.dmg -o Docker.dmg
    echo "Curling Sublime text..."
    curl https://download.sublimetext.com/Sublime%20Text%20Build%203207.dmg -o sublime.dmg

    echo "You can now install Docker and SublimeText from the .dmg files in your cwd."
else
    echo ''
    echo "Skipping dmg downloads..."
fi

echo "Now setting default shell..."
chsh -s $(which zsh); exit 0
if [[ $? -eq 0 ]] then
    echo "Successfully set your default shell to zsh..."
else
    echo "Default shell not set successfully..." >&2
fi
