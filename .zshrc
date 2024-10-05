autoload -Uz compinit
compinit

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload '_history_substring_search_config'
zinit load agkozak/zsh-z
zinit snippet OMZ::plugins/alias-finder
zinit snippet OMZ::plugins/kitty
zinit snippet OMZ::plugins/mvn
zinit ice lucid as"program" pick"bin/git-dsf"
zinit load so-fancy/diff-so-fancy

# zstyles
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases.zsh
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh
# Functions.zsh
[[ -f ~/.config/zsh/functions.zsh ]] && source ~/.config/zsh/functions.zsh
# dibnet_aliases.zsh
[[ -f ~/.config/zsh/dibnet_aliases.zsh ]] && source ~/.config/zsh/dibnet_aliases.zsh

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# MVN
# export MVN_HOME=~/Tools/apache-maven-3.9.2
# export PATH=$MVN_HOME/bin:$PATH

# Rust
# export PATH="$HOME/.cargo/bin:$PATH"

# Load Angular CLI autocompletion.
source <(ng completion script)

# Java
#export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH" # for openjdk download from brew
#export JAVA_HOME=$(/usr/libexec/java_home -v 17)
. ~/.asdf/plugins/java/set-java-home.zsh

# Go 
. ~/.asdf/plugins/golang/set-env.zsh

# fuck command
eval $(thefuck --alias fuck)
zinit snippet OMZ::plugins/thefuck

# fzf settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# grc
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

# bun completions
[ -s "/Users/ianmcbee/.bun/_bun" ] && source "/Users/ianmcbee/.bun/_bun"

export ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
source "${ASDF_DIR}/asdf.sh"
zinit fpath -f "${ASDF_DIR}/completions"
zicompinit

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

if [[ "$TERM_PROGRAM" != "Apple_Terminal" && "$TERM_PROGRAM" != "WarpTerminal" ]]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi

# Starship
if [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; then
  eval "$(starship init zsh)"

  [ -f ~/.transient-prompt.zsh ] && source ~/.transient-prompt.zsh
fi

if [[ "$TERM_PROGRAM" != "vscode" ]]; then
  fastfetch
fi