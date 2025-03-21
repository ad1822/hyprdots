if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# # Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# # Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# # Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light xylous/gitstatus
zinit light zsh-users/zsh-history-substring-search

# # Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
#zinit snippet OMZP::archLinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
#zinit snippet OMZP::go
zinit snippet OMZP::kubectx
#zinit snippet OMZP::docker
zinit snippet OMZP::command-not-found
zinit snippet OMZP::terraform

# # Load completions
autoload -Uz compinit && compinit

#."$HOME/"


# zinit cdreplay -q


# # Keybindings
bindkey -e
bindkey '^[ '   autosuggest-execute
bindkey '^[Z ' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region


# # History
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

# # Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# # Aliases
alias vim='nvim'
#alias man='tldr'

# # Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

alias isc='nvim $(fzf -m --preview="bat --color=always {}")'
alias ls='eza -l --header  --tree --level=1  --all --sort=Name'
alias search='eval "~/.local/bin/search.sh"'
alias code='code .'
alias tnew='tmux new -s '
alias tatt='tmux a -t'

take() {
    mkdir -p "$1" && cd "$1"
}


#fastfetch

#wl-paste --watch cliphist store &
eval $(thefuck --alias)
eval "$(atuin init zsh)"

eval "$(starship init zsh)"


export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"


#alias connectGit='
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
 #   eval "$(ssh-agent -s)"
#fi
#ssh-add ~/.ssh/id_ed25519
#'


export PATH=$HOME/.config/rofi/scripts:$PATH
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export EDITOR=/bin/nvim
#. "/home/archer/.deno/env"
#export PATH="$HOME/anaconda3/bin:$PATH"
# bun completions
#[ -s "/home/archer/.bun/_bun" ] && source "/home/archer/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#eval "$(ssh agent -s)" > /dev/null

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
