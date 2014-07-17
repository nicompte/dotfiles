#!/usr/bin/env bash

sudo -v

# Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

DOTFILES=$(pwd)

echo "  Installing homebrew"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

echo "  Installing brew packages, might take a while..."
brew bundle brew/Brewfile

# Installation oh my zshrc
echo "  Installing oh my zsh"
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

echo "  Installing cask packages, might take a while..."
brew bundle cask/Caskfile

source npm/npm.sh

mkdir $DOTFILES/backups

# git
mkdir $DOTFILES/backups/git
mv $HOME/.gitconfig $DOTFILES/backups/git/gitconfig.back
mv $HOME/.gitignore_global $DOTFILES/backups/git/gitignore_global.back
ln -s $DOTFILES/git/gitconfig $HOME/.gitconfig
ln -s $DOTFILES/git/gitignore_global $HOME/.gitignore_global

# zsh
mv $HOME/.zshrc $DOTFILES/backups/.zshrc.back
ln -s $DOTFILES/zsh/zshrc $HOME/.zshrc

# iterm2
mkdir $DOTFILES/backups/iterm2
mv $HOME/Library/Preferences/com.googlecode.iterm2.plist $DOTFILES/backups/iterm2/com.googlecode.iterm2.plist.back
ln -s $DOTFILES/iterm2/com.googlecode.iterm2.plist $HOME/Library/Preferences/com.googlecode.iterm2.plist

# atom
mkdir $DOTFILES/backups/atom
mv $HOME/.atom/config.cson $DOTFILES/backups/atom/config.cson.back
mv $HOME/.atom/init.coffee $DOTFILES/backups/atom/init.coffee.back
mv $HOME/.atom/keymap.cson $DOTFILES/backups/atom/keymap.cson.back
mv $HOME/.atom/snippets.cson $DOTFILES/backups/atom/snippets.cson.back
mv $HOME/.atom/styles.less $DOTFILES/backups/atom/styles.less.back
mkdir -p $HOME/.atom
ln -s $DOTFILES/atom/config.cson $HOME/.atom/config.cson
ln -s $DOTFILES/atom/init.coffee $HOME/.atom/init.coffee
ln -s $DOTFILES/atom/keymap.cson $HOME/.atom/keymap.cson
ln -s $DOTFILES/atom/snippets.cson $HOME/.atom/snippets.cson
ln -s $DOTFILES/atom/styles.less $HOME/.atom/styles.less
