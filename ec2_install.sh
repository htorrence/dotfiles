#!/bin/bash

sudo yum install emacs
rm .bash_profile
rm .bashrc
./dotfiles/install.sh

source bash_profile
