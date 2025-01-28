set AL2_FZF_BINDINGS "$HOME/.fzf/shell/key-bindings.fish"
set MACOS_FZF_BINDINGS "/opt/homebrew/opt/fzf/shell/key-bindings.fish"

if type -q fzf
    if test -f $AL2_FZF_BINDINGS
        source $AL2_FZF_BINDINGS
    else
        # Or on macOS with Homebrew:
        source $MACOS_FZF_BINDINGS
    end
    fzf_key_bindings
end

set -gx FZF_DEFAULT_OPTS '--height 40% --border'
set -gx FZF_DEFAULT_COMMAND 'fd --type f'  # if you have fd installed
