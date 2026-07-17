# ==============================================================================
# PLUGIN CONFIGURATIONS (zstyles)
# ==============================================================================
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':completion:*:git*(checkout|switch|branch)*:*' sort false
zstyle ':completion:*:git*(checkout|switch|branch)*:*' fzf-flags --height=50% --preview-window=right:70%
zstyle ':fzf-tab:complete:docker*:*' fzf-flags --height=50% --preview-window=right:70%
zstyle ':fzf-tab:complete:git*:*' fzf-flags --height=50% --preview-window=right:60%
zstyle ':fzf-tab:complete:make*:*' fzf-flags --height=50% --preview-window=right:70%
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:zinit:*' fzf-flags --no-preview
zstyle ':fzf-tab:complete:asdf:*' fzf-flags --no-preview

# FZF Interactive Previews
zstyle ':fzf-tab:complete:*:*' fzf-preview '
  # Fallback to $word if $realpath is empty
  local target="${realpath:-$word}"
  # Safely expand tilde (~) if present in the path
  target=${~target}

  if [[ -d "$target" ]]; then
    eza -1 --color=always --group-directories-first --icons=always "$target" 2>/dev/null || ls -1 --color=always "$target"
  elif [[ -f "$target" ]]; then
    bat --color=always --style=numbers --line-range=:500 "$target" 2>/dev/null || cat "$target"
  else
    echo "Value: $word"
  fi'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --level=2 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza --tree --level=2 --color=always --icons=always "${realpath:-$word}"'
zstyle ':fzf-tab:complete:make:*' fzf-preview 'make help'
zstyle ':fzf-tab:complete:git*:*' fzf-preview '
  # FIX: Safely enable extended globbing locally to strip trailing whitespace
  setopt localoptions extendedglob
  local target="${word%%[[:space:]]#}"

  # Safely extract the subcommand whether typed with a space or a hyphen
  local subcmd="${words[1]#git-}"
  [[ "$words[1]" == "git" ]] && subcmd="$words[2]"

  case "$subcmd" in
    checkout|switch)
      case "$group" in
        "modified file") 
          git diff --color=always "$target" 2>/dev/null | head -200 
          ;;
        "recent commit object name"|"commit tag") 
          git show --color=always "$target" 2>/dev/null | head -200 
          ;;
        *) 
          # Try showing local log; if it fails, fall back to the origin remote log
          { git log --oneline --graph --decorate --color=always "$target" || 
            git log --oneline --graph --decorate --color=always "origin/$target"; } 2>/dev/null | head -200
          ;;
      esac
      ;;
    diff|add|restore)
      git diff --color=always "$target" 2>/dev/null | head -200
      ;;
    log)
      { git log --oneline --graph --decorate --color=always "$target" || 
        git log --oneline --graph --decorate --color=always "origin/$target"; } 2>/dev/null | head -200
      ;;
    show)
      git show --color=always "$target" 2>/dev/null | head -200
      ;;
    branch)
      { git log --oneline --graph --decorate --color=always "$target" || 
        git log --oneline --graph --decorate --color=always "origin/$target"; } 2>/dev/null | head -200
      ;;
  esac'
zstyle ':fzf-tab:complete:docker*:*' fzf-preview '
  # Strip the phantom trailing space from Zsh completion
  setopt localoptions extendedglob
  local target="${word%%[[:space:]]#}"

  case "$group" in
    *"container"*)
      docker inspect "$target" 2>/dev/null | bat -pl json --color=always
      ;;
    *"image"*|*"repository"*|*"tag"*)
      docker image inspect "$target" 2>/dev/null | bat -pl json --color=always
      ;;
    *"volume"*)
      docker volume inspect "$target" 2>/dev/null | bat -pl json --color=always
      ;;
    *"network"*)
      docker network inspect "$target" 2>/dev/null | bat -pl json --color=always
      ;;
    *"command"*|*"argument"*|*"subcommand"*)
      # Use bat -pl help to render beautifully formatted CLI help pages
      if [[ "$words[2]" =~ ^(container|image|volume|network|system|context)$ ]]; then
        docker "$words[2]" "$target" --help 2>/dev/null | head -40 | bat -pl help --color=always
      else
        docker "$target" --help 2>/dev/null | head -40 | bat -pl help --color=always
      fi
      ;;
    *)
      # Dynamic Fallback: Try inspecting as JSON first, then help manual, else print cleanly
      if docker inspect "$target" &>/dev/null; then
        docker inspect "$target" | bat -pl json --color=always
      elif docker "$target" --help &>/dev/null; then
        docker "$target" --help | head -40 | bat -pl help --color=always
      else
        echo "Completing: $target"
      fi
      ;;
  esac'
zstyle ':fzf-tab:complete:export:*' fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:kill:*' fzf-preview 'ps --pid=$word -o cmd --no-headers'
zstyle ':fzf-tab:complete:kill:*' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:brew:*' fzf-preview \
  'case "$group" in
    *"formula"*) brew info --formula "$word" | bat --color=always --style=plain --language=help ;;
    *"cask"*)    brew info --cask "$word" | bat --color=always --style=plain --language=help ;;
    *)           (brew help "$word" 2>/dev/null || brew "$word" --help) | bat --color=always --style=plain --language=help ;;
  esac'
