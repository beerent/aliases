addAlias() {
  local alias_name="$1"
  local alias_value="$2"
  local alias_file="$ALIASES_HOME/aliases"

  echo "alias $alias_name='$alias_value'" >> "$alias_file"
}

removeAlias() {
  local alias_name="$1"
  local alias_file="$ALIASES_HOME/aliases"

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

