#!/bin/bash

for f in "bash_profile" "gitconfig" "bashrc" "emacs" "emacs.d" "profile"; do
    ln -s ~/dotfiles/$f ~/.$f
done 
