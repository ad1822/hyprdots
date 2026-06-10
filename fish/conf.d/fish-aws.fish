# Load state if enabled
if test "$AWS_PROFILE_STATE_ENABLED" = true
    set -q AWS_STATE_FILE; or set -gx AWS_STATE_FILE /tmp/.aws_current_profile
    if test -s $AWS_STATE_FILE
        set -l aws_state (cat $AWS_STATE_FILE)

        if test (count $aws_state) -ge 1
            set -gx AWS_DEFAULT_PROFILE $aws_state[1]
            set -gx AWS_PROFILE $AWS_DEFAULT_PROFILE
            set -gx AWS_EB_PROFILE $AWS_DEFAULT_PROFILE
        end

        if test (count $aws_state) -lt 2; or test -z "$aws_state[2]"
            set -l region (aws configure get region)
            if test -n "$region"
                set -gx AWS_REGION $region
            end
        else
            set -gx AWS_REGION $aws_state[2]
        end

        if test -n "$AWS_REGION"
            set -gx AWS_DEFAULT_REGION $AWS_REGION
        end
    end
end
