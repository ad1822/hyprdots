function gh-create
    git init
    gh repo create --private --source=. --remote=origin
    git push -u --all
    gh browse
end

function add
    git add --patch
end

# function commit
#     bash ~/work/main/dotsh/gh/commit
# end

# function push
#     git push
# end

function tag
    git tag $argv[1]
    git push origin $argv[1]
end

function clear-local-branches
    git branch --merged dev | grep -v '\*' | grep -v dev | xargs git branch -d
end

function gh-visibility
    gh repo edit --accept-visibility-change-consequences --visibility "$argv[1]"
end

function gh-open
    gh browse
    # set repo (basename (pwd))
    # xdg-open "https://github.com/ad1822/$repo"
end
