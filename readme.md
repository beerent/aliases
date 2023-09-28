This utility is a generic tool to dynamicly support the addition and removal of aliases on the fly.

setup:
1. clone the repo to some directory, for example:
  /Users/bartsimpson/repos

2. add the three lines of code to your .zshrc or .bashrc file:
export ALIASES_HOME="/Users/bartsimpson/repos"
source $ALIASES_HOME/aliases
source $ALIASES_HOME/alias_functions.sh

3. re-source your .zshrc or .bashrc

You're all setup!

Usage:
- add_alias (alias_name, alias_value)
  - example: add_alias hello "echo 'world'"

- remove-alias (alias_name)
  - example: remove_alias hello
