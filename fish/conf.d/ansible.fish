# Auto-use ansible from venv
set -gx ANSIBLE_HOME /home/ad/work/side/ansible-dotfiles

if test -f $ANSIBLE_HOME/.venv/bin/ansible
    alias ansible="$ANSIBLE_HOME/.venv/bin/ansible"
    alias ansible-playbook="$ANSIBLE_HOME/.venv/bin/ansible-playbook"
    alias ansible-inventory="$ANSIBLE_HOME/.venv/bin/ansible-inventory"
    alias ansible-vault="$ANSIBLE_HOME/.venv/bin/ansible-vault"
    alias ansible-galaxy="$ANSIBLE_HOME/.venv/bin/ansible-galaxy"
    alias ansible-config="$ANSIBLE_HOME/.venv/bin/ansible-config"
    alias ansible-doc="$ANSIBLE_HOME/.venv/bin/ansible-doc"
end
