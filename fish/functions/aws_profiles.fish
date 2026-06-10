function aws_profiles --description "List available AWS profiles"
    # Try AWS CLI v2 command first
    # if aws --no-cli-pager configure list-profiles 2>/dev/null
    #     return
    # end

    # Fall back to parsing config file
    set -l config_file (test -n "$AWS_CONFIG_FILE"; and echo $AWS_CONFIG_FILE; or echo "$HOME/.aws/config")
    if not test -r $config_file
        return 1
    end

    grep -Eo '\[.*\]' $config_file | sed -E 's/^[[:space:]]*\[(profile)?[[:space:]]*([^[:space:]]+)\][[:space:]]*$/\2/g'
end
