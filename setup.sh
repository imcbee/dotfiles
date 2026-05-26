#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status,
# if an uninitialized variable is used, or if a piped command fails.
set -euo pipefail

# Get the absolute path of the dotfiles directory where this script lives
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "========================================="
echo "  Starting Dotfiles Bootstrap Script     "
echo "========================================="

# 1. Install Homebrew if it isn't already installed
if ! command -v brew &>/dev/null; then
  echo "▶ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Dynamically load Homebrew into the current environment execution (Apple Silicon vs Intel)
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "✔ Homebrew is already installed."
fi

# 2. Update Homebrew and install dependencies from the Brewfile
if [ -f "Brewfile" ]; then
  echo "▶ Installing packages from Brewfile..."
  brew update
  brew bundle --file=Brewfile
else
  echo "⚠️ Warning: No Brewfile found at $DOTFILES_DIR/Brewfile. Skipping bundle install."
fi

# 3. Create target directories to prevent GNU Stow conflicts
# CRITICAL STOW TIP: If ~/.config doesn't exist as a real folder, Stow will symlink
# the entire folder to your first package, breaking subsequent packages trying to use it.
echo "▶ Preparing target directories..."
mkdir -p "$HOME/.config"

# 4. Create Symlinks using GNU Stow
echo "▶ Creating symlinks with GNU Stow..."

# Define the stow packages you want to symlink to $HOME
STOW_PACKAGES=(
  zsh
  obsidian
)

for package in "${STOW_PACKAGES[@]}"; do
  if [ -d "$package" ]; then
    echo "  Stowing: $package"
    # -R : Restow (removes old/broken links and applies new ones)
    # -v : Verbose output so you can see exactly what links are made
    # -t : Target directory (your user home folder)
    stow -R -v -t "$HOME" "$package"
  else
    echo "  ❌ Skipped: '$package' directory not found in dotfiles."
  fi
done

echo "========================================="
echo "       Bootstrapping Complete!           "
echo "  Restart your terminal to see changes.  "
echo "========================================="
