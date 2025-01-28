if status is-interactive
    fish_vi_key_bindings

    # Homebrew setup
    eval $(/opt/homebrew/bin/brew shellenv)

    # NVM setup (for language servers mostly)
    if test -x "/opt/homebrew/opt/nvm/nvm.sh"
        set -gx NVM_DIR "$HOME/.nvm"
        source "/opt/homebrew/opt/nvm/nvm.sh"
    end

end
