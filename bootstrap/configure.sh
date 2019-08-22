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

echo "Installing packages..."
brew install ack \
    autoconf \
    awscli \
    cairo \
    certbot \
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
    giflib \
    git \
    bash-completion \
    glib \
    gmp \
    gnupg \
    gnutls \
    go \
    graphite2 \
    harfbuzz \
    htop \
    jq \
    kubectx \
    kubernetes-cli \
    kubernetes-helm \
    leiningen \
    libevent \
    libffi \
    libgcrypt \
    libgpg-error \
    little-cms2 \
    maven \
    mitmproxy \
    ncurses \
    nmap \
    node \
    openssl \
    protobuf \
    pyenv \
    pyenv-virtualenv \
    pyenv-virtualenvwrapper \
    python \
    readline \
    ruby \
    sqlite \
    stern \
    syncthing \
    terraform \
    tmux \
    tree \
    vim \
    watchman \
    zsh \
    zsh-completions


echo ''
echo "Now configuring git-completion..."
GIT_VERSION=`git --version | awk '{print $3}'`
URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
echo ''
echo "Downloading git-completion for git version: $GIT_VERSION..."
if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
	echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
fi

# oh-my-zsh install
echo ''
echo "Now installing oh-my-zsh..."
echo ''
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh plugin install
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

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

# Speedtest-cli and jq install
brew install jq speedtest-cli

# Pull down personal dotfiles
echo ''
echo "Now pulling down your dotfiles..."
git clone https://github.com/misdirectedpuffin/dotfiles.git ~/.dotfiles
echo ''
cd $HOME/.dotfiles && echo "switched to .dotfiles dir..."
echo 'Syncing dotfiles with bonclay...'
bonclay sync bonclay.conf.yaml
then
    echo "Successfully configured your environment with dotfiles..."
else
    echo "dotfiles were not applied successfully..." >&2
# Set default shell to zsh
echo ''

echo "Now setting default shell..."
chsh -s $(which zsh); exit 0
if [[ $? -eq 0 ]] then
    echo "Successfully set your default shell to zsh..."
else
    echo "Default shell not set successfully..." >&2
fi
echo ''
echo '	Badass macOS terminal installed!'