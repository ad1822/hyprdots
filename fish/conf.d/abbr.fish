abbr -a gs 'git status'
abbr -a gco 'git checkout'

abbr -a kls 'kubectl get all'
abbr -a k kubectl
abbr -a ls 'eza -l --icons -a --tree --git --color=always --sort=Name --level=1'
abbr -a search 'eval "~/.local/bin/search.sh"'
abbr -a cod 'code .'

# Tmux
abbr -a t 'tmux new -s '
abbr -a tt 'tmux attach-session -t'
abbr -a fbat 'fzf --preview \'bat --style=numbers --color=always --line-range :500 {}\''

abbr -a cAll 'killall waybar hyprpaper hypridle'
abbr -a seek pacseek
abbr -a y yazi
abbr -a ci cdi

# Path navigations
abbr -a .... 'cd ../..'
abbr -a .. 'cd ..'
abbr -a ~ 'cd ~'

abbr -a st systemctl-tui
abbr -a tf terraform
abbr -a user "set -x AWS_PROFILE$argv[1]"
abbr -a ld lazydocker
abbr -a restart-fish "source ~/.config/fish/config.fish"
abbr -a pager "jq -C . | less -R"
abbr -a dcdown "docker compose down"
abbr -a dcup "docker compose up"
abbr -a dc docker
abbr -a rm "rm -i"

# abbr -a awsr "aws $1 --profile root"
# abbr -a homelab-start "cd /home/ad/work/side/homelab && docker compose up -d && firefox localhost:3737"
# abbr -a homelab-close "cd /home/ad/work/side/homelab && docker compose down"
