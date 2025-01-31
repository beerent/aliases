# Function to load and parse aliases
load_aliases() {
    # Initialize associative array for storing alias mappings
    typeset -A alias_mappings
    
    # Read aliases from your alias file and store them in the array
    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "$line" ]] && continue
        
        # Extract alias name and value
        if [[ "$line" =~ ^alias[[:space:]]+([^=]+)=(.+)$ ]]; then
            name="${match[1]}"
            value="${match[2]}"
            # Remove surrounding quotes if present
            value="${value#[\"\']}"
            value="${value%[\"\']}"
            # Store with the actual command as key and alias as value
            alias_mappings[$value]=$name
        fi
    done < "$HOME/.aliases"
    
    # Return each key-value pair on a separate line
    for cmd alias in "${(@kv)alias_mappings}"; do
        print "$cmd:$alias"
    done
}

# Preexec hook function
alias_helper_hook() {
    local cmd="$1"
    
    # Create a local associative array
    typeset -A aliases
    
    # Load aliases into the array
    while IFS=: read -r command alias_name; do
        [[ -n "$command" ]] && aliases[$command]=$alias_name
    done < <(load_aliases)
    
    # Check if the command matches any alias values
    for value command in "${(@kv)aliases}"; do
        if [[ "$cmd" == "$value" ]]; then
            print "\nℹ️  You could have used the alias: $command"
            print "Press any key to continue..."
            read -k 1
            return
        fi
    done
}

# Add the hook to preexec_functions
autoload -U add-zsh-hook
add-zsh-hook preexec alias_helper_hook
