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
  echo "✅ Homebrew is already installed."
fi

# 2. Update Homebrew and install dependencies from the Brewfile
if [ -f "Brewfile" ]; then
  echo "▶ Installing packages from Brewfile..."
  brew update
  brew bundle --file=Brewfile
else
  echo "⚠️ Warning: No Brewfile found at $DOTFILES_DIR/Brewfile. Skipping bundle install."
fi

# 3. Setup asdf plugins and runtime languages (Node.js & Python)
echo "▶ Setting up asdf version manager..."

# Since this script runs in a fresh shell instance, we must manually
# locate and source asdf so its commands work immediately.
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  source "$HOME/.asdf/asdf.sh"
elif command -v brew &>/dev/null && [ -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]; then
  source "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
fi

if command -v asdf &>/dev/null; then
  # CRITICAL: If 'asdf plugin list' is empty, it returns exit code 1.
  # We append '|| true' so 'set -e' doesn't crash our script.
  CURRENT_PLUGINS=$(asdf plugin list 2>/dev/null || true)

  # --- Node.js Setup ---
  if ! echo "$CURRENT_PLUGINS" | grep -q "^nodejs$"; then
    echo "  Adding asdf nodejs plugin..."
    asdf plugin add nodejs
  fi
  echo "  Installing/Updating Node.js (latest)..."
  asdf install nodejs latest
  asdf global nodejs latest

  # --- Python Setup ---
  if ! echo "$CURRENT_PLUGINS" | grep -q "^python$"; then
    echo "  Adding asdf python plugin..."
    asdf plugin add python
  fi
  echo "  Installing/Updating Python (latest)..."
  asdf install python latest
  asdf global python latest
else
  echo "⚠️ Warning: 'asdf' command not found. Skipping language runtime setup."
  echo "   (Ensure 'asdf' is added to your Brewfile or installed manually)"
fi

# 4. Check if the .lazy-idea directory does NOT exist
if [ ! -d "$HOME/.lazy-idea" ]; then
  echo "Installing lazy-idea..."
  git clone https://github.com/cufarvid/lazy-idea.git "$HOME/.lazy-idea"
else
  echo "✅ lazy-idea is already installed, skipping."
fi

# 5. Create target directories to prevent GNU Stow conflicts
echo "▶ Preparing target directories..."
mkdir -p "$HOME/.config"

# 6. Create Symlinks using GNU Stow
echo "▶ Creating symlinks with GNU Stow..."

# Automatically discover all directories, ignoring hidden ones and specific files
for package in */; do
  # Remove trailing slash for cleaner text output
  package="${package%/}"

  # Skip specific directories you don't want GNU Stow to touch
  if [[ "$package" == "logs" || "$package" == "documentation" ]]; then
    continue
  fi

  echo "  Stowing: $package"
  # -R : Restow (removes old/broken links and applies new ones)
  # -t : Target directory (your user home folder)
  stow -R -v -t "$HOME" "$package"
done

echo "========================================="
echo "       Bootstrapping Complete!           "
echo "  Restart your terminal to see changes.  "
echo "========================================="
