# -------------------------------------------------------------------
# DIBNET Aliases
# -------------------------------------------------------------------
##### CHANGE THESE VARIABLES TO POINT TO WHERE YOUR PROJECTS ARE LOCATED #####
dibnet_2='~/code/dibnet-2'
dibnet_3='~/code/dibnet-3'
icf='~/code/dibnet'

# change directories
alias project='cd ~/code'
alias pull-all='project; find . -mindepth 2 -maxdepth 2 -type d -print -exec git -C {} pull \;'
alias fetch-all='project; find . -mindepth 2 -maxdepth 2 -type d -print -exec git -C {} fetch \;'
alias bah-angular-uswds='cd '$dibnet_3'/bah-angular-uswds'
alias dibnet-docker='cd '$dibnet_3'/dibnet-docker'
alias dibnet-services='cd '$dibnet_3'/dibnet-services'
alias dibnet-terraform='cd '$dibnet_3'/dibnet-terraform'
alias dibnet-ui='cd '$dibnet_3'/dibnet-ui'
alias dibnet-commons='cd '$dibnet_3'/dibnet-commons'
alias dibnet-icf-automation='cd '$icf'/dibnet-icf-automation'
alias dibnet-automation='cd '$dibnet_3'/dibnet-automation'
alias dibnet-icf='cd '$icf'/dibnet-icf/icf-app'
alias dibnet-2='cd '$dibnet_2''

# build scripts
alias cleanup='dibnet-docker; ./scripts/cleanup.sh'
alias stop='dibnet-docker; ./scripts/stop.sh'

alias build-commons='dibnet-commons; mvn clean install -DskipTests '
alias build-service='dibnet-services; mvn clean install -DskipTests '
alias build-service-fast='dibnet-services; mvn clean install -T4 -DskipTests '
alias build-ui='dibnet-ui; ./scripts/build-docker.sh'
alias build-lite='build-ui; build-service'
alias build-icf='dibnet-icf; cd ..; mvn clean install -DskipTests '
alias build-all='build-ui; build-service; build-icf'

alias deploy-lite-icf='dibnet-docker; ./scripts/build-all.sh skipTests; ./scripts/build-icf.sh skipTests; docker_start lite-icf'
alias deploy-aws-icf='cleanup; ./scripts/build-all.sh skipTests; ./scripts/build-icf.sh skipTests; docker_start aws-icf' 
alias redeploy-ui='dibnet-docker; ./scripts/redeploy-ui.sh; dibnet-ui;'
alias redeploy-ui-prod='dibnet-docker; ./scripts/redeploy-ui.sh prod'
alias redeploy-service='dibnet-docker; ./scripts/redeploy-service.sh'
alias redeploy-icf-ui='dibnet-docker; ./scripts/redeploy-icf-ui.sh; dibnet-icf;'
alias redeploy-aws-icf='cleanup && ./scripts/build-icf.sh skipTests && docker_start aws-icf; dibnet-icf;'

alias docker_start='dibnet-docker; ./scripts/start.sh'

# docker logs
alias logs='dibnet-docker; ./scripts/logs.sh'

alias docker_start-lite-logs='build-all; scripts/start.sh lite && logs -f'
alias docker_start-openldap-logs='build-all; scripts/start.sh openldap && logs -f'


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

