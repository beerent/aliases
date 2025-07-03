#!/usr/bin/env zsh
# Zsh completion functions for alias management
# Save this as ~/.zsh_alias_completions and source from .zshrc

# Helper function to get existing alias names from your .aliases file
_get_alias_names() {
    local alias_file="$HOME/.aliases"
    if [[ -f "$alias_file" ]]; then
        grep "^alias " "$alias_file" | sed -E "s/^alias ([^=]+)=.*$/\1/"
    fi
}

# Completion function for remove_alias
_remove_alias() {
    local -a alias_names
    alias_names=(${(f)"$(_get_alias_names)"})
    _describe 'aliases' alias_names
}

# Completion function for add_alias
_add_alias() {
    case $CURRENT in
        2)
            # First argument: alias name (no completion needed, user types new name)
            _message "alias name"
            ;;
        3)
            # Second argument: could complete with commands in PATH
            _command_names
            ;;
    esac
}

# Completion function for save_alias
_save_alias() {
    case $CURRENT in
        2)
            # Only argument: alias name (no completion needed, user types new name)
            _message "alias name"
            ;;
    esac
}

# Register the completion functions
compdef _remove_alias remove_alias
compdef _add_alias add_alias
compdef _save_alias save_alias
# list_aliases takes no arguments, so no completion needed

# Optional: Enhanced completion that also shows alias values
_remove_alias_enhanced() {
    local alias_file="$HOME/.aliases"
    local -a alias_descriptions
    
    if [[ -f "$alias_file" ]]; then
        while IFS= read -r line; do
            if [[ "$line" =~ ^alias[[:space:]]+([^=]+)=(.+)$ ]]; then
                local name="${match[1]}"
                local value="${match[2]}"
                # Remove surrounding quotes
                value="${value#[\"\']}"
                value="${value%[\"\']}"
                # Truncate long values for display
                if [[ ${#value} -gt 50 ]]; then
                    value="${value:0:47}..."
                fi
                alias_descriptions+=("$name:$value")
            fi
        done < "$alias_file"
        
        _describe 'aliases' alias_descriptions
    fi
}

# Uncomment the line below if you want to see alias values during completion
# compdef _remove_alias_enhanced remove_alias
