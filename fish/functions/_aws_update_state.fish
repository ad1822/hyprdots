function _aws_update_state
    if test "$AWS_PROFILE_STATE_ENABLED" = true
        if not test -d (dirname $AWS_STATE_FILE)
            exit 1
        end
        if test -z "$AWS_REGION"
            echo "$AWS_PROFILE" >$AWS_STATE_FILE
        else
            echo "$AWS_PROFILE $AWS_REGION" >$AWS_STATE_FILE
        end
    end
end
