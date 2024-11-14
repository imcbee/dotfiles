# delete all docker images and volumes
alias prune='docker system prune -a --volumes'

# remove the node_modules folder and the package-lock.json file from the current directory
alias remove-node_modules='rm -rf node_modules; rm package-lock.json'

# -------------------------------------------------------------------
# Obsidian Aliases
# -------------------------------------------------------------------
#alias obsidian='cd ~/Documents/Work-Obsidian-Github-Repo'
#alias obsidian-status='obsidian; gs'
#alias obsidian-update='obsidian; ga .; gm "obsidian update"; gp origin main;'

# -------------------------------------------------------------------
# NPM Aliases
# -------------------------------------------------------------------
alias nr="npm run"
alias ni="npm install"
alias ns="npm start"
alias nu="npm uninstall"

# -------------------------------------------------------------------
# Git Aliases
# -------------------------------------------------------------------
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'

# leverage an alias from the ~/.gitconfig
alias gh='git hist'

# -------------------------------------------------------------------
# Dockercolorize
# -------------------------------------------------------------------

di() {
  docker images "$@" | dockercolorize
}

dps() {
  docker ps "$@" | dockercolorize
}

dcps() {
  docker compose ps "$@" | dockercolorize
}

dpsa() {
  docker ps -a "$@" | dockercolorize
}

dstats() {
  docker stats --no-stream "$@" | dockercolorize
}

# alias ll='ls -lG'

# -------------------------------------------------------------------
# p10K
# -------------------------------------------------------------------
# alias update-p10k='git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull'

# -------------------------------------------------------------------
# EZA Commands to replace ls
# -------------------------------------------------------------------
alias ld='eza -lD --header'
alias lf='eza -lF --header --color=always | grep -v /'
alias lh='eza -dl .* --group-directories-first'
alias ll='eza -al --header --group-directories-first'
alias ls='eza -alF --header --color=always --sort=size | grep -v /'
alias lt='eza -al --header --sort=modified'

alias l='eza --git-ignore $eza_params'
alias llm='eza --all --header --long --sort=modified $eza_params'
alias la='eza -lbhHigUmuSa'
alias lx='eza -lbhHigUmuSa@'
alias tree='eza --tree $eza_params'

# -------------------------------------------------------------------
# Bat
# -------------------------------------------------------------------
alias cat='bat'
alias bathelp='bat --plain --language=help'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias man='batman'
alias ripgrep='batgrep'

alias idea='open -na "/Applications/IntelliJ IDEA CE.app" --args "$@"'

# -------------------------------------------------------------------
# dotfiles
# -------------------------------------------------------------------
dotfiles='~/dotfiles'
alias dotfiles='cd '$dotfiles''

# -------------------------------------------------------------------
# doom
# -------------------------------------------------------------------
doom='~/Documents/terminal-doom'
alias doom='cd '$doom'; zig-out/bin/terminal-doom'

# -------------------------------------------------------------------
# air
# -------------------------------------------------------------------
alias air='$(go env GOPATH)/bin/air'
