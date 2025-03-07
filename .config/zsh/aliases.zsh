# Switching to arm64 to x86 quickly
alias x86="$env /usr/bin/arch -x86_64 /bin/zsh ---login"
alias arm="$env /usr/bin/arch -arm64 /bin/zsh ---login"

# delete all docker images and volumes
alias prune='docker system prune -a --volumes'

# remove the node_modules folder and the package-lock.json file from the current directory
alias remove-node_modules='rm -rf node_modules; rm package-lock.json'

# -------------------------------------------------------------------
# Obsidian Aliases
# -------------------------------------------------------------------
alias obsidian='cd ~/Documents/Obsidian'

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
# EZA Commands to replace ls
# -------------------------------------------------------------------
alias ld='eza -lD --header --group-directories-first --icons=always'
alias lf='eza -lF --header --color=always --group-directories-first --icons=always | grep -v /'
alias lh='eza -dl .* --group-directories-first --icons=always'
alias ll='eza -al --header --group-directories-first --icons=always'
alias ls='eza -alF --header --color=always --sort=size --group-directories-first --icons=always | grep -v /'
alias lt='eza -al --header --sort=modified --group-directories-first --icons=always'

alias l='eza --git-ignore --group-directories-first --icons=always $eza_params'
alias llm='eza --all --header --long --sort=modified --group-directories-first --icons=always $eza_params'
alias la='eza -lbhHigUmuSa --group-directories-first --icons=always'
alias lx='eza -lbhHigUmuSa@ --group-directories-first --icons=always'
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
# air (go)
# -------------------------------------------------------------------
alias air='$(go env GOPATH)/bin/air'
