add_alias() {
  local alias_name="$1"
  local alias_value="$2"
  local alias_file="$HOME/.aliases"

  local alias_value_escaped="$(echo "$alias_value" | sed "s/'/'\\\\''/g")"

  echo "alias $alias_name='$alias_value_escaped'" >> "$alias_file"
  echo "added alias $alias_name -> [$alias_value]"

  # Source the modified alias file to apply changes to the current session
  source "$alias_file"
}

save_alias() {
  local alias_name="$1"
  # if is zsh
  if [ "$SHELL" = "/bin/zsh" ]; then
    local alias_value=$(history -1 | awk '{$1=""; print substr($0,2)}')
  else
    local alias_value=$(history 2 | head -n1 | awk '{$1=""; print substr($0,2)}')
  fi
  local alias_file="$HOME/.aliases"

  local alias_value_escaped="$(echo "$alias_value" | sed "s/'/'\\\\''/g")"

  echo "alias $alias_name='$alias_value_escaped'" >> "$alias_file"
  echo "added alias $alias_name -> [$alias_value]"

  # Source the modified alias file to apply changes to the current session
  source "$alias_file"
}

remove_alias() {
  local alias_name="$1"
  local alias_file="$HOME/.aliases"

  # Check if the alias file exists
  if [ -f "$alias_file" ]; then
    # Use grep to remove the alias line from the file
    grep -v "alias $alias_name=" "$alias_file" > "$alias_file.tmp"
    
    # Rename the temporary file back to the original file
    mv "$alias_file.tmp" "$alias_file"
    
    # Source the modified alias file to apply changes to the current session
    source "$alias_file"
    
    echo "Alias '$alias_name' removed."
  else
    echo "Alias file '$alias_file' not found."
  fi
}

list_aliases() {
  local alias_file="$HOME/.aliases"

  # Check if the alias file exists
  if [ -f "$alias_file" ]; then
    echo "List of Aliases:"
    echo "----------------"
    # Use grep to extract and display alias lines from the file
    grep "^alias " "$alias_file" | sed -E "s/^alias ([^=]+)='(.*)'$/\1='\2'/"
  else
    echo "Alias file '$alias_file' not found."
  fi
}

