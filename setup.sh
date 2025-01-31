# 1. create files where we store aliases
if [ ! -f ~/.aliases ]; then
  touch ~/.aliases
fi

# 2. source relevent files based on shell
if [ "$SHELL" = "/bin/zsh" ]; then
  if [ -z "$ALIASES_HOME" ]; then
    echo "" >> ~/.zshrc
    echo "export ALIASES_HOME=\"$PWD\"" >> ~/.zshrc
    echo "source ~/.aliases" >> ~/.zshrc
    echo "source $PWD/alias_functions.sh" >> ~/.zshrc
    echo "source $PWD/alias_detector.zsh" >> ~/.zshrc
  fi

elif [ "$SHELL" = "/bin/bash" ]; then
  if [ -z "$ALIASES_HOME" ]; then
    echo "" >> ~/.bashrc
    echo "export ALIASES_HOME=\"$PWD\"" >> ~/.bashrc
    echo "source ~/.aliases" >> ~/.bashrc
    echo "source $PWD/alias_functions.sh" >> ~/.bashrc

    # not supported yet for bash
    #echo "source $ALIASES_HOME/alias_detector.sh" >> ~/.bashrc
  fi
else
  echo "Unsupported shell"
  exit 1
fi

clear
echo "Welcome to alias heaven 🚀"
echo ""
echo "There are four commands to explore:"
echo "1. add_alias <alias> \"<command>\"  create a new alias"
echo "2. save_alias <alias>             saves the last command as an alias"
echo "3. remove_alias <alias>           remove an alias"
echo "4. list_alises                    list all aliases"
echo ""

echo ""
echo "To get started, run the following command:"
if [ "$SHELL" = "/bin/zsh" ]; then
  echo "   source ~/.zshrc"
elif [ "$SHELL" = "/bin/bash" ]; then
  echo "   source ~/.bashrc"
fi
echo ""


echo ""
echo "here's some homework, create your first alias to make adding aliases easier:"
echo "   add_alias aa \"add_alias\""
echo ""


echo ""
echo "once you've done that, add a second alias using your new shortcut 'aa'!"
echo ""

echo ""
echo  "enjoy your dynamic aliases 😎" 
echo ""
