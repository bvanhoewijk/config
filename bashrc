# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac


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

######################## START BETTER TERMINAL
PROMPT_DIRTRIM=3

git_prompt() {
    local branch dirty=""

    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null)
    [ -z "$branch" ] && branch=$(git rev-parse --short HEAD 2>/dev/null)

    # Modified/staged files
    if ! git diff --quiet --ignore-submodules -- 2>/dev/null ||
       ! git diff --cached --quiet --ignore-submodules -- 2>/dev/null; then
        dirty="*"

    # Untracked files
    elif [ -n "$(git ls-files --others --exclude-standard | head -n 1)" ]; then
        dirty="*"
    fi

    if [ -n "$dirty" ]; then
        printf ' \e[38;5;244mgit:\e[38;5;214m%s\e[38;5;196m*\e[0m' "$branch"
    else
        printf ' \e[38;5;244mgit:\e[38;5;214m%s\e[0m' "$branch"
    fi
}

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[38;5;45m\]╭─\[\033[0m\]\[\033[97m\][\[\033[38;5;39m\]${CONDA_DEFAULT_ENV:-base}\[\033[97m\]]\[\033[0m\] \[\033[01;32m\]\u@\h\[\033[0m\] \[\033[38;5;244m\]in\[\033[0m\] \[\033[01;34m\]\w\[\033[0m\]$(git_prompt)\n\[\033[38;5;45m\]╰─❯\[\033[0m\] '
else
    PS1='╭─[${CONDA_DEFAULT_ENV:-base}] \u@\h in \w$(git_prompt)\n╰─❯ '
fi

######################## END BETTER TERMINAL
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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


# Alias definitions.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Pass hook
fp () {
	local paz=$(find ~/.password-store/ -name "*.gpg"  | \
		sed -r 's,(.*)\.password-store/(.*)\.gpg,\2,'   | \
		fzf +m) 
	[[ ! -z "$paz" ]] && echo $paz && EDITOR=vim pass $* $paz
}
