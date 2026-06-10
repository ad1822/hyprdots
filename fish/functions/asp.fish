function asp --description "Set AWS_PROFILE with <profile>"
    if test (count $argv) -eq 0
        set -e AWS_DEFAULT_PROFILE AWS_PROFILE AWS_EB_PROFILE AWS_PROFILE_REGION
        _aws_clear_state
        echo "AWS profile cleared."
        return
    end

    set -l available_profiles (aws_profiles)
    set -l profile_found 0
    for prof in $available_profiles
        if test "$prof" = "$argv[1]"
            set profile_found 1
            break
        end
    end

    if test $profile_found -eq 0
        set_color red
        echo "Profile '$argv[1]' not found in '"(test -n "$AWS_CONFIG_FILE"; and echo $AWS_CONFIG_FILE; or echo "$HOME/.aws/config")"'" >&2
        echo "Available profiles: "(string join ", " $available_profiles)"" >&2
        set_color normal
        return 1
    end

    set -gx AWS_DEFAULT_PROFILE $argv[1]
    set -gx AWS_PROFILE $argv[1]
    set -gx AWS_EB_PROFILE $argv[1]

    set -gx AWS_PROFILE_REGION (aws configure get region)

    _aws_update_state

    if test (count $argv) -ge 2; and test "$argv[2]" = login
        if test (count $argv) -ge 3
            aws sso login --sso-session $argv[3]
        else
            aws sso login
        end
    else if test (count $argv) -ge 2; and test "$argv[2]" = logout
        aws sso logout
    end
end
