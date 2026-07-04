# ==============================================================================
# 1. INSTANT PROMPT & FASTFETCH
# ==============================================================================
if [ -z "$FASTFETCH_RUN" ] && [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]; then
    export FASTFETCH_RUN=1
    fastfetch
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# 2. PLUGIN MANAGER (ZINIT) INITIALIZATION
# ==============================================================================
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

autoload -Uz compinit; compinit -C

# ==============================================================================
# 3. ZSH PLUGINS (Optimized with Turbo Mode)
# ==============================================================================
# Load immediately for immediate UI styling
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab
zinit light asdf-vm/asdf

# Lazy-load everything else asynchronously using Turbo Mode (wait"0")
zinit ice wait"0" lucid; zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice wait"0" lucid; zinit load agkozak/zsh-z
zinit ice wait"0" lucid; zinit snippet OMZ::plugins/alias-finder
zinit ice wait"0" lucid; zinit snippet OMZ::plugins/kitty
zinit ice wait"0" lucid; zinit snippet OMZP::mvn
zinit ice wait"0" lucid; zinit light 22peacemaker/zsh-make-complete

zinit ice wait"0" lucid atload"
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
"
zinit load zsh-users/zsh-history-substring-search

# Note: Autosuggestions and Syntax Highlighting are placed last intentionally 
# to prevent breaking syntax coloring on text inputs.
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# ==============================================================================
# 4. HISTORY SETTINGS
# ==============================================================================
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ==============================================================================
# 5. EXTERNAL FILE SOURCING & ENVIRONMENT PATHS
# ==============================================================================
# Define where your custom Zsh modules live
ZSH_CONFIG_DIR="$HOME/.config/zsh"

# Automatically source all .zsh files inside that directory
if [[ -d "$ZSH_CONFIG_DIR" ]]; then
  for config_file in "$ZSH_CONFIG_DIR"/*.zsh; do
    source "$config_file"
  done
fi

# ==============================================================================
# 6. BINARY OPTIMIZATIONS
# ==============================================================================
# Optimized FZF (Caches the code to a file so it doesn't execute dynamically on launch)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [[ ! -f ~/.cache/fzf-zsh.zsh ]]; then
    mkdir -p ~/.cache
    fzf --zsh > ~/.cache/fzf-zsh.zsh 2>/dev/null
fi
[[ -f ~/.cache/fzf-zsh.zsh ]] && source ~/.cache/fzf-zsh.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
