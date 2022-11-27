# dotfiles

Merged repo of my common dotfiles.

## Setup

To install the dotfiles to your user environment, run the `boot.sh` script. See
additional notes for macOS and Linux below.

## macOS Notes

Additional manual setup:

- Install homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Install systems tools using homebrew:

```
brew install \
    asdf \
    fzf \
    nvim \
    rustup \
    starship \
    tmux \
    wget \
    ripgrep \

```

- Optional new-school CLI tools:

```
brew install \
    bat \
    exa \
    fd \
    hyperfine \

```


... add to `~/.zshrc_local` all the source material for fzf, asdf, starhip

- asdf
  - `asdf plugin add python`

## Linux Notes

TODO
