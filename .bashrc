# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Using this, consecutive duplicate commands, invocations
# of ls, plus calls to the bg, fg and exit
# built-ins will not be appended to the history list. 
HISTIGNORE="&:ls:ls *:[bf]g:exit:vi"
export HISTIGNORE

##############################################################################
# git
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
} 

if [ -f ~/.config/.git-completion.bash ]; then
		. ~/.config/.git-completion.bash
fi

##############################################################################
# two-line ps1
# $
PS1='\[\033[01;37m\](\u@\h \w)$(parse_git_branch)\n$ \[\033[00m\]' # white, rounded, git status

##############################################################################
# aliases
alias ls='ls -FG'
alias l='ls -aFG'
alias ll='ls -alFG'

alias rm='rm -i'
alias .='pwd'
alias ..='cd ..'

# force grep into color mode; short alias for recursive grep
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
function gr() { grep -nr $@ *; }

##############################################################################
# defaults
EDITOR=vi;   	export EDITOR
PAGER=less;  	export PAGER # git diff expects 'less' for best output
PATH=$PATH:$HOME/bin:/usr/local/sbin

##############################################################################
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
