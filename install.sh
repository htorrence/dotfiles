#!/bin/zsh

brew install --cask emacs
brew install direnv

# Function to backup and link dotfiles
link_dotfile() {
    local file=$1
    local source=~/code/dotfiles/$file
    local target=~/.$file
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "Warning: $target already exists"
        read "response?Do you want to remove it and create a symlink? (y/n) "
        if [[ "$response" =~ ^[Yy]$ ]]; then
            rm -rf "$target"
            ln -s "$source" "$target"
            echo "Linked $target -> $source"
        else
            echo "Skipped $file"
        fi
    else
        ln -s "$source" "$target"
        echo "Linked $target -> $source"
    fi
}

# Link dotfiles
for f in "gitconfig" "zshrc" "emacs.d" ; do
    link_dotfile "$f"
done 

# Link iTerm2 preferences
iterm_pref=~/Library/Preferences/com.googlecode.iterm2.plist
if [ -e "$iterm_pref" ] || [ -L "$iterm_pref" ]; then
    echo "Warning: iTerm2 preferences already exist"
    read "response?Do you want to remove and link to dotfiles version? (y/n) "
    if [[ "$response" =~ ^[Yy]$ ]]; then
        rm "$iterm_pref"
        ln -s ~/code/dotfiles/com.googlecode.iterm2.plist "$iterm_pref"
        echo "Linked iTerm2 preferences"
    else
        echo "Skipped iTerm2 preferences"
    fi
else
    ln -s ~/code/dotfiles/com.googlecode.iterm2.plist "$iterm_pref"
    echo "Linked iTerm2 preferences"
fi

source ~/.zshrc
