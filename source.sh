source ~/.aliases
source $ALIASES_HOME/alias_functions.sh

if [ "$SHELL" = "/bin/zsh" ]; then
  source $ALIASES_HOME/alias_detector.zsh

  autoload -Uz compinit
  compinit
  source $ALIASES_HOME/alias_completions.zsh
fi

