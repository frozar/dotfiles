# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	    # We have color support; assume it's compliant with Ecma-48
	    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	    # a case would tend to support setf rather than setaf.)
	    color_prompt=yes
    else
	    color_prompt=
    fi
fi

date_str="[\$(date +%H:%M)] "
if [ ${debian_chroot} ]; then
    debian_chroot_str="${debian_chroot:+($debian_chroot)} "
else
    debian_chroot_str=""
fi

# Prepend
PS1=${date_str}${debian_chroot_str}
# Check the color feature of the terminal and set the correspongind git branch string
if [ "$color_prompt" = yes ]; then
    PS1=${PS1}"\[\033[01;35m\]\u\[\033[00m\]@\[\033[01;32m\]\h\[\033[00m\] : \[\033[01;33m\]\w\[\033[00m\] "
    if [ `which git` ]; then
        git_branch_name="\[\033[01;31m\]\$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/{ \1 } /')\[\033[00m\]"
    else
        git_branch_name=""
    fi
else
    PS1=${PS1}"\u@\h : \w "
    if [ `which git` ]; then
        git_branch_name="\$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/{ \1 } /')"
    else
        git_branch_name=""
    fi
fi
# Postpend
export PS1=${PS1}${git_branch_name}"$\n"
export PS2='-> '

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

# # Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Custom aliases
alias em='emacs'
alias top="top -d 0,5 -H"
alias htop="htop -d 1,5"

# Enable/disable proxy connexion through jumbox
alias tunnel_ssh_toggle='if [ "$(ps -ef | grep ssh | grep jumpbox | awk '\''{$1=$1};1'\'' | cut -d" " -f2)" == "" ] ; then echo "LAUNCH ssh tunnel via jumpbox" ; (ssh -N -q -D 8009 jumpbox &) ; else echo "EXIT jumpbox ssh tunnel" ; kill $(ps -ef | grep ssh | grep jumpbox | awk '\''{$1=$1};1'\'' | cut -d" " -f2) ; fi'
alias tunnel_ssh_status='if [ "$(ps -ef | grep ssh | grep jumpbox | awk '\''{$1=$1};1'\'' | cut -d" " -f2)" == "" ] ; then echo "tunnel: DISABLE" ; else echo "tunnel: ENABLE" ; fi'


# Update soler docker : dockersegmentation:v1
alias update_soler='(echo "cd pcl ; git checkout master ; git fetch -p ; git reset --hard origin/master ; docker build --no-cache --tag tmp_dockersegmentation:v1 . ; docker tag tmp_dockersegmentation:v1 dockersegmentation:v1 ; docker rmi -f tmp_dockersegmentation:v1" | ssh soler )'

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

# # colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# If the remote git adress is an https, doesn't check the authenticity of the SSL certificat
export GIT_SSL_NO_VERIFY=1
# Use emacs as default git commit editor
export GIT_EDITOR=emacs

# Configuration for LMGC90
export PYTHONPATH=${PYTHONPATH}:${HOME}/wk/lmgc90_dev/build

# Configuration for FreeCAD
export PYTHONPATH=${PYTHONPATH}:/usr/lib/freecad-daily/lib

# Add path toward ccache (try to speed PCL compilation)
export PATH=/usr/lib/ccache:${PATH}

# # Add toward Rust utilities ('cargo' for example)
# export PATH=${HOME}/.cargo/bin:${PATH}

# # Special environment variables to debug IntelliSense from Visual Studio Code
# export VSCODE_CPP_LOGFILE_LEVEL=5; export VSCODE_CPP_LOGDIR=/home/frozar/tmp/code
# # commande to type in Visual Studio Code
# C/Cpp : Reset IntelliSense Database

# Special environment variable to build debian package
export DEBFULLNAME="Fabien Rozar"
export DEBEMAIL="fabien.rozar@gmail.com"

# # PCL project: environment variable
# export OMP_NUM_THREADS=2
# export OMP_NESTED=TRUE

# # Use the graphical card
# # Get the name of the graphic card available
# xrandr --listproviders
# # Set the correct graphic card, for example:
# xrandr --setprovideroffloadsink "OLAND @ pci:0000:04:00.0"
# Force the use of the graphical card
export DRI_PRIME=1
# WThe effective usage of the graphical card can be check with 'sudo radeontop'

# With qmake, Choose Qt5 as default
# export QTTOOLDIR="/usr/lib/x86_64-linux-gnu/qt5/bin"
export QT_SELECT="qt5"