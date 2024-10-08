# ~/.bashrc: executed by bash(1) for non-login shells.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
    [ $? == 0 ] && exit_status="✅" || exit_status="⚠";

    # If not running interactively, don't do anything
    case $- in
        *i*) ;;
          *) return;;
    esac

    # get current branch in git repo
    function parse_git_branch() {
        BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
        if [ ! "${BRANCH}" == "" ]
        then
            echo "(${BRANCH})"
        else
            echo ""
        fi
    }

    PS1="$exit_status @\[\033[01;32m\]\u \[\033[01;34m\]\W\[\e[35m\]\`parse_git_branch\`\[\033[00m\]:\[\e[m\] \[\033[00m\]\$ "
}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

today()
{
    echo Today is `date +"%A, %dth of %B, %Y (%r)"`
    return
}

newFolder ()
{
  newDir="$1"
  [[ -z $newDir ]] && newDir="NewFolder"
  mkdir -p -- "$newDir" && cd -P -- "$newDir"
}

go ()
{
    cd "$1"
    pwd
    ls -al
}

