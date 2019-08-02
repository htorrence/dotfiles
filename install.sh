#!/bin/bash

for f in "bash_profile" "gitconfig" "bashrc" "emacs" "emacs.d" "profile"; do
    ln -sfn ~/dotfiles/$f ~/.$f
done 

source .bash_profile
