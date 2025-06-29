export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
#export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export PATH=$PATH:/opt/kafka/bin
export PATH=$HOME/.config/rofi/scripts:$PATH
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export EDITOR=/bin/nvim

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice lucid as"program" pick"bin/git-dsf"
zinit load so-fancy/diff-so-fancy

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light romkatv/gitstatus
zinit light zsh-users/zsh-history-substring-search


zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::terraform

autoload -Uz compinit && compinit
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'


zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

# # Keybindings
bindkey -e
bindkey '^[ '   autosuggest-execute
bindkey '^[Z ' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

cd_up() {
    cd ..
    zle reset-prompt
}

cdt() {
    if [ -z "$1" ]; then
        echo "Usage: cdl <project-directory>"
        return 1
    fi
    
    PROJECT_DIR="$1"
    SESSION_NAME=$(basename "$PROJECT_DIR")
    
    
    cd "$PROJECT_DIR" || return
    
    if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
        tmux attach-session -t "$SESSION_NAME"
    else
        tmux new-session -d -s "$SESSION_NAME" -n main -c "$PROJECT_DIR"
        tmux new-window  -t "$SESSION_NAME":1 -n worker1 -c "$PROJECT_DIR"
        tmux new-window  -t "$SESSION_NAME":2 -n worker2 -c "$PROJECT_DIR"
        tmux new-window  -t "$SESSION_NAME":3 -n logs    -c "$PROJECT_DIR"
        tmux select-window -t "$SESSION_NAME":1
        tmux attach-session -t "$SESSION_NAME"
    fi
}


zle -N cd_up
bindkey '^H' cd_up

cd_menu() {
    local dir
    dir=$(eza -1 --color=always --icons --group-directories-first | fzf --ansi --preview 'eza --tree --level=1 --icons --color=always {}')
    [[ -n "$dir" ]] && cd "$dir" && zle reset-prompt
}

zle -N cd_menu
bindkey '^L' cd_menu

HISTSIZE=5001
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

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


export FZF_TMUX=1
# export FZF_TMUX_OPTS='-p 80%,60%'
# export FZF_DEFAULT_OPTS="--height 100%  --border"

# # Shell integrations
eval "$(fzf --zsh)"
export _ZO_ECHO='0'
eval "$(zoxide init --cmd cd zsh)"
eval $(thefuck --alias)
eval "$(atuin init zsh)"
eval "$(starship init zsh)"

alias vim='nvim'

alias gh-create='git init && gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'

add(){
    git add --patch
}

commit(){
    bash ~/work/main/dotsh/gh/commit
}

push(){
    git push
}

ms(){
    touch "$1" && chmod +x "$1"
}

alias kls='kubectl get all'

alias jump='nvim $(fzf -m --preview="bat --color=always {}")'
alias ls='eza -l --icons --level=0 --tree --sort=Name'
alias search='eval "~/.local/bin/search.sh"'
alias cod='code .'

# Tmux
alias t='tmux new -s '
alias tt='tmux a -t'
alias fbat="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

alias seek='pacseek'
alias y='yazi'
alias ci='cdi'
alias ....='cd ../..'
alias ..='cd ..'
alias ~='cd ~'

# Edit Config files
edit() {
    code ~/.config/$1
}

cpcf() {
    local file
    
    file=$(fzf --query="$1" --preview 'bat --color=always {}' --preview-window 'right:60%' --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up')
    
    if [ -n "$file" ]; then
        cat "$file" | wl-copy
        echo "Copied: $file"
    else
        echo "No file selected."
    fi
}

# For connecting google drive to local
mount_gdrive() {
    rclone mount gdrive: ~/mnt/gdrive
}

# For opening repo in browser
gh_open() {
    repo=$(basename $(pwd))
    xdg-open "https://github.com/ad1822/$repo"
}

backup_dots(){
    exec syncAll.sh
}


fcd(){
    local dir
    dir=$(find ${1:-.} -type d -not -path '*/\.*' 2> /dev/null | fzf +m) && cd "$dir"
}

# Extract
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.gz)  tar -xzf "$1"      ;;
            *.tar.xz)  tar -xf "$1"       ;;
            *.tar.bz2) tar -xjf "$1"      ;;
            *.gz)      gunzip "$1"        ;;
            *.bz2)     bunzip2 "$1"       ;;
            *.zip)     unzip "$1"         ;;
            *.Z)       uncompress "$1"    ;;
            *.7z)      7z x "$1"          ;;
            *)         echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

killp() {
    ps aux | fzf | awk '{print $2}' | xargs kill -9
}

j() {
    local dir
    dir=$(eza -1 --color=always --icons --group-directories-first  | fzf --ansi) && cd "$(echo "$dir" | awk '{print $NF}')"
}


take() {
    mkdir -p "$1" && cd "$1"
}

c() {
    cd "$1" && ls
}

music() {
    xdg-open https://music.youtube.com/
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
complete -C '/usr/bin/aws_completer' aws

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

#fortune | cowsay

# Todo Manager Alias
alias todo='~/.todo/todo_tui.sh'
alias todocli='~/.todo/todo_cli.sh'

# nitch
fastfetch
