#### ALIASES ####
alias em='/usr/bin/emacs -nw'
alias ls='ls -F '
alias ll='ls -alhs'
alias lr='ls -ltur'
alias l.='ls -d .*'
alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'

#### FUNCTIONS ####
up() { cd $(eval printf '../'%.0s {1..$1}) && pwd;}

s() { # do sudo, or sudo the last command if no argument given
    if [[ $# == 0 ]]; then
	sudo $(history -p '!!')
    else
	sudo "$@"
    fi
}

title() { echo -ne "\033]0;"$*"\007";}
#### VARIABLES ####
export EDITOR=em
export HISTCONTROL=ignoredups

##### Extraction Tools ####
function extract()  
{
    if [ -f $1 ] ; then
	case $1 in
	    *.tar.bz2)   tar xvjf $1     ;;
	    *.tar.gz)    tar xvzf $1     ;;
	    *.bz2)       bunzip2 $1      ;;
	    *.rar)       unrar x $1      ;;
	    *.gz)        gunzip $1       ;;
	    *.tar)       tar xvf $1      ;;
	    *.tbz2)      tar xvjf $1     ;;
	    *.tgz)       tar xvzf $1     ;;
	    *.zip)       unzip $1        ;;
	    *.Z)         uncompress $1   ;;
	    *.7z)        7z x $1         ;;
	    *)           echo "'$1' cannot be extracted via >extract<" ;;
	esac
    else
	echo "'$1' is not a valid file!"
    fi
    }

# Creates an archive (*.tar.gz) from given directory.

function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }
