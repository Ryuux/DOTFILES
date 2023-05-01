export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(zsh-syntax-highlighting zsh-autosuggestions git)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Functions
mkcd () {
  if [ $# -ne 1 ]; then
    local dir="untitled"
  else
    local dir="$1"
  fi
  if ! test -w "$(dirname "$dir")"; then
    echo "No tienes permiso para escribir en el directorio padre"
    return 1
  fi
  mkdir -p -- "./$dir" && cd -- "./$dir"
}

extract () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)  tar xjf "$1"     ;;
      *.tar.gz)   tar xzf "$1"     ;;
      *.bz2)      bunzip2 "$1"     ;;
      *.rar)      unrar e "$1"     ;;
      *.gz)       gunzip "$1"      ;;
      *.tar)      tar xf "$1"      ;;
      *.tbz2)     tar xjf "$1"     ;;
      *.tgz)      tar xzf "$1"     ;;
      *.zip)      unzip "$1"       ;;
      *.Z)        uncompress "$1"  ;;
      *)          echo "'$1' no se puede extraer" ;;
    esac
  else
    echo "'$1' no es un archivo válido"
  fi
}

fcd () {
  local result="$(find . -type d -name "$1" | head -n 1)"
  if [ -n "$result" ] ; then
    cd "$result"
  else
    echo "Directorio no encontrado: $1"
    return 1
  fi
}

gitignore () {
  if [ -e .gitignore ] ; then
    echo ".gitignore ya existe"
  else
    echo "# .gitignore" > .gitignore
    echo "$@" >> .gitignore
    echo ".gitignore creado"
  fi
}

cd() {
  builtin cd "$@" && ls -a
}

mdless () {
  pandoc -s -f markdown -t man "$1" | less
}

# Aliases
alias update='sudo apt-get update && sudo apt-get upgrade'
alias install='sudo apt install'


alias ll='exa -lFh'
alias lt='exa -lFhS'
alias lf='exa -lFhrt'
alias lla='exa -laFh'
alias lsc='exa -lFhc --color-scale'
alias lsd='exa -lFhc --color-scale=256'

alias refresh="source .zshrc"

alias rm='rm -i -r'
alias du='du -sh'
alias sysinfo='neofetch'
alias restart='exec $SHELL'
alias h='history | grep'
alias psa='ps -aux'


# Vscode
alias vsc='code .'
# Python 3
alias python='python3'
alias pip='pip3'

# Node.js y NPM
alias n='npm'
alias ni='npm install'
alias nis='npm install --save'
alias nig='npm install --global'
alias nr='npm run'
alias nt='npm test'
alias np='npm publish'

# PNPM
alias p='pnpm'
alias pi='pnpm install'
alias pis='pnpm install --save'
alias pig='pnpm install --global'
alias pr='pnpm run'
alias pt='pnpm test'
alias pp='pnpm publish'

# Exports
export PATH="/home/ryuux/.deno/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# bun completions
[ -s "/home/ryuux/.bun/_bun" ] && source "/home/ryuux/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
