complete -c aws -f -a "(begin
    set -lx COMP_SHELL fish
    set -lx COMP_LINE (commandline)
    aws_completer
end)"
