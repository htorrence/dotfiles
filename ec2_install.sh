#!/bin/bash

sudo yum install emacs
rm .bash_profile
rm .bashrc
rm .profile
rm .gitconfig
./dotfiles/install.sh

source .bash_profile
