if status is-interactive
    # Commands to run in interactive sessions can go here

    abbr -a vim nvim
    abbr -a vi nvim

    abbr -a l eza
    abbr -a la eza -a
    abbr -a ll eza -lah

    abbr -a gits git status
    abbr -a gcm git commit -m

    abbr -a mw mwinit -f
    abbr -a c autossh -M 2010 bfj-cdm
    abbr -a y autossh -M 2020 yukou

end
