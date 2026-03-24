#!/bin/bash

# Function to create a symlink after removing any existing file, directory, or symlink
create_symlink() {
    local target=$1
    local link=$2

    if [ -e "$link" ]; then
        echo "Removing existing file, directory, or symlink: $link"
        rm -rf "$link" && echo "Removed: $link" || echo "Failed to remove: $link"
    fi

    echo "Creating symlink: $link -> $target"
    ln -s "$target" "$link" && echo "Symlink created: $link" || echo "Failed to create symlink: $link"
}

# List of files/directories to link
declare -A links=(
    ["$HOME/dotfiles/.config/zsh"]="$HOME/.config/zsh"
    ["$HOME/dotfiles/.config/alias"]="$HOME/.config/alias"
    ["$HOME/dotfiles/.config/profile"]="$HOME/.config/profile"
    ["$HOME/dotfiles/.zshrc"]="$HOME/.zshrc"
    ["$HOME/dotfiles/.tmux.conf"]="$HOME/.tmux.conf"
    ["$HOME/dotfiles/.p10k.zsh"]="$HOME/.p10k.zsh"
)

# Loop through and create symlinks
for target in "${!links[@]}"; do
    create_symlink "$target" "${links[$target]}"
done

echo "All symlinks have been created successfully!"
