# Homebrew Initialization
eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by Toolbox App
export PATH="$PATH:/Users/ianmcbee/Library/Application Support/JetBrains/Toolbox/scripts"

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# Set editor to nvim
export EDITOR="nvim"

# Set vi-mode to 1 Esc
export KEYTIMEOUT=1

# ASDF
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Maven
export PATH=$HOME/.sdkman/candidates/maven/current/bin:$PATH

# Golang
. ~/.asdf/plugins/golang/set-env.zsh

# Add scripts to PATH 
export PATH="$HOME/scripts:$PATH"

# terminal-browser
export PATH="$HOME/.local/bin:$PATH"


# SDK & Language Version Manager Environments
[[ -f ~/.asdf/plugins/java/set-java-home.zsh ]] && . ~/.asdf/plugins/java/set-java-home.zsh
[[ -f ~/.asdf/plugins/golang/set-env.zsh ]] && . ~/.asdf/plugins/golang/set-env.zsh
