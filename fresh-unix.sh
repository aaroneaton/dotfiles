#!/bin/bash

echo "Setting up your server..."

mkdir ~/tmp

# Install ZSH
echo "Installing ZSH"
apt install -y zsh
chsh -s $(which zsh)

# Install oh-my-zsh
echo "Installing oh-my-zsh"
[ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Removes .vimrc from $HOME (if it exists) and symlinks the .vimrc file from the .dotfiles
rm -rf $HOME/.vimrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc

# Symlink tmux.conf
rm -rf $HOME/.tmux.conf
ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf

# Install Tmux Plugin Manager
rm -rf ~/.tmux/plugins/tpm  || true
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tmux plugins.
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Update repositories
apt update

# Install some dependencies
apt install -y php-cli unzip ubuntu-make

# Install AWS CLI
echo "==== Installing AWS CLI"
pushd ~/tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
popd

# Install The Silver Searcher (ag)
apt-get install -y silversearcher-ag

# Install Composer
echo "==== Installing Composer"
pushd ~/tmp
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
popd

# Install NVM
echo "==== Installing NVM"
pushd ~/tmp
[ ! -d "$HOME/.nvm" ] && sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash)"
popd

# Cleanup
echo "==== Cleaning up"
[ ! -d "$HOME/.vim/swaps" ] && mkdir -p ~/.vim/swaps
[ ! -d "$HOME/.vim/backups" ] && mkdir -p ~/.vim/backups
rm -rf ~/tmp

echo "==== Done!"
