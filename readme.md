This utility is a generic tool to dynamicly support the addition and removal of aliases on the fly.

setup:
1. clone the repo to some directory.
example:
  /Users/bartsimpson/repos

2. source this new repo, as well as the aliases file via .zshrc or .bashrc
example:
  export ALIASES_HOME="/Users/bartsimpson/repos/aliases"
  source ~/.aliases
  source $ALIASES_HOME/alias_functions.sh

3. re-source your .zshrc or .bashrc

You're all setup!

Usage:
* add_alias (alias_name, alias_value)
  - example: add_alias hello "echo 'world'"

* remove_alias (alias_name)
  - example: remove_alias hello

* list_aliases
