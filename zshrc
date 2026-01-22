#### ALIASES ####
alias em="emacs -nw"
alias ls='ls -F '
alias ll='ls -alhs'
alias lr='ls -ltur'
alias l.='ls -d .*'
alias folders='du -hd 1 | sort -h'
alias dockerstop='docker stop $(docker ps -aq)'
alias clean_branches='git branch | grep -v "main" | xargs git branch -d'
alias gcplogin='gcloud auth application-default login'


#### FUNCTIONS ####
up() { cd $(eval printf '../'%.0s {1..$1}) && pwd;}

s() { # do sudo, or sudo the last command if no argument given
    if [[ $# == 0 ]]; then
	sudo $(fc -ln -1)
    else
	sudo "$@"
    fi
}

title() { echo -ne "\033]0;"$*"\007";}


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

function prepend(){
# @author Abdennour TOUMI
if [ -e $2 ]; then
    sed -i -e "1i `cat $1`" $2
fi

}


function remind () {
  local COUNT="$#"
  local COMMAND="$1"
  local MESSAGE="$1"
  local OP="$2"
  shift 2
  local WHEN="$@"
  # Display help if no parameters or help command
  if [[ $COUNT -eq 0 || "$COMMAND" == "help" || "$COMMAND" == "--help" || "$COMMAND" == "-h" ]]; then
    echo "COMMAND"
    echo "    remind <message> <time>"
    echo "    remind <command>"
    echo
    echo "DESCRIPTION"
    echo "    Displays notification at specified time"
    echo
    echo "EXAMPLES"
    echo '    remind "Hi there" now'
    echo '    remind "Time to wake up" in 5 minutes'
    echo '    remind "Dinner" in 1 hour'
    echo '    remind "Take a break" at noon'
    echo '    remind "Are you ready?" at 13:00'
    echo '    remind list'
    echo '    remind clear'
    echo '    remind help'
    echo
    return
  fi
  # Check presence of AT command
  if ! which at >/dev/null; then
    echo "remind: AT utility is required but not installed on your system. Install it with your package manager of choice, for example 'sudo apt install at'."
    return
  fi
  # Run commands: list, clear
  if [[ $COUNT -eq 1 ]]; then
    if [[ "$COMMAND" == "list" ]]; then
      at -l
    elif [[ "$COMMAND" == "clear" ]]; then
      at -r $(atq | cut -f1)
    else
      echo "remind: unknown command $COMMAND. Type 'remind' without any parameters to see syntax."
    fi
    return
  fi
  # Determine time of notification
  if [[ "$OP" == "in" ]]; then
    local TIME="now + $WHEN"
  elif [[ "$OP" == "at" ]]; then
    local TIME="$WHEN"
  elif [[ "$OP" == "now" ]]; then
    local TIME="now"
  else
    echo "remind: invalid time operator $OP"
    return
  fi
  # Schedule the notification
  echo "notify-send '$MESSAGE' 'Reminder' -u critical" | at $TIME 2>/dev/null
  echo "Notification scheduled at $TIME"
}

# uv
export PATH="/Users/hanna/.local/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hanna/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hanna/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hanna/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hanna/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
