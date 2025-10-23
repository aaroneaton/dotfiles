#!/bin/sh

echo "====> Setting up your Raspberry Pi..."

# Removes .vimrc from $HOME (if it exists) and symlinks the .vimrc file from the .dotfiles
rm -rf $HOME/.vimrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc

# Removes tmux configuration (if it exists) and symlinks .tmux.conf and .tmux folder from the .dotfiles
rm -rf $HOME/.tmux.conf $HOME/.tmux
ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/.dotfiles/.tmux $HOME/.tmux

# Update repositories
sudo apt update

# Install applications
sudo apt-get install -y silversearcher-ag \
  zsh \
  tmux \
  fonts-powerline \
  build-essential

# Change default shell to ZSH
chsh -s $(which zsh)

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Create the swap and backup directories for vim
mkdir -p $HOME/.vim/backups
mkdir -p $HOME/.vim/swaps

# Add the global .gitignore
git config --global core.excludesfile ~/.dotfiles/.gitignore_global

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo usermod -aG docker $USER
rm get-docker.sh

echo "====> All done! Make sure to log out and back in before proceeding."
