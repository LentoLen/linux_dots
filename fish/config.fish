if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    neofetch
    fish_add_path "$HOME/.local/bin"
    
    # aliases
    alias pac "sudo pacman"
    alias cl "clear"
end
