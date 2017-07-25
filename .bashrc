if [ -e $HOME/.environment ]; then
  source $HOME/.environment
fi

if [ -e $HOME/.bashrc_noninteractive_$OSTYPE ]; then
  source $HOME/.bashrc_noninteractive_$OSTYPE
fi

if [ -e $HOME/.bashrc_noninteractive_$LOCATION ]; then
  source $HOME/.bashrc_noninteractive_$LOCATION
fi

# Don't do anything further if running non-interactively
if [ -z "$PS1" ]; then
  return
fi

git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

# Set prompt/window title
PS1="\u@\h:\w\$(git_branch)\$ "
if [[ "$TERM" =~ "xterm" ]]; then
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}\007"'
fi

shopt -s cdspell
shopt -s checkwinsize

# Control-Q
stty start undef
# Control-S
stty stop undef
# Control-W
stty werase undef
# Control-\
stty quit undef

CDPATH=:.:..:$HOME
alias dotfiles='GIT_DIR=$HOME/.dotfiles.git GIT_WORK_TREE=$HOME'
alias gdb='gdb -quiet'
makeopts=-j$(getconf _NPROCESSORS_ONLN)
alias make='make --no-print-directory $makeopts'

if [ -x /usr/bin/vim ]; then
  alias vi='vim'
  alias vim='vim -p'
fi

if [ -e $HOME/.bashrc_interactive_$OSTYPE ]; then
  source $HOME/.bashrc_interactive_$OSTYPE
fi

if [ -e $HOME/.bashrc_interactive_$LOCATION ]; then
  source $HOME/.bashrc_interactive_$LOCATION
fi
