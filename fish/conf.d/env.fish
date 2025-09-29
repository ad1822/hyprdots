set -x GOPATH $HOME/go
set PATH $HOME/.local/bin $PATH
set -x PATH $GOPATH/bin $PATH
set -Ux PATH $PATH /opt/kafka/bin
set -Ux PATH $HOME/.config/rofi/scripts $PATH
set PATH $HOME/.cargo/bin/ $PATH
# set -Ux STARSHIP_CONFIG ~/.config/starship/starship.toml
set EDITOR nvim
set BROWSER zen-browser
set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
# Fd
# set -Ux FD_DEFAULT_OPTS "--hidden --exclude .git --exclude node_modules --exclude .cache"

# Fzf

set -Ux FZF_DEFAULT_OPTS "--height 80% --layout=reverse --border rounded --info=inline --color=bg+:#11111b:,fg+:#cdd6f4,prompt:#89b4fa,pointer:#f38ba8"

set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --preview 'bat --style=numbers --color=always {} | head -200'"

set -Ux FZF_TMUX 1

set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#313244,bg:#11111b,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#6C7086,label:#CDD6F4"
