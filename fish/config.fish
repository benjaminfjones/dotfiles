if status is-interactive
    fish_vi_key_bindings

    # PATH additions
    fish_add_path $HOME/.toolbox/bin
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.elan/bin

    # Set up mise for runtime management
    if test -x "/opt/homebrew/bin/mise"; or test -x "$HOME/.local/bin/mise"
        mise activate fish | source
    end

    if test -d "/opt/homebrew"
        # Homebrew setup
        eval $(/opt/homebrew/bin/brew shellenv)

        # NVM setup (for language servers mostly)
        if test -x "/opt/homebrew/opt/nvm/nvm.sh"
            set -gx NVM_DIR "$HOME/.nvm"
            source "/opt/homebrew/opt/nvm/nvm.sh"
        end
    end

    set -gx AWS_PROFILE bfj

end
