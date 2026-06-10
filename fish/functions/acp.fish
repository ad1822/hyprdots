function acp --description 'Set AWS_PROFILE by assuming the AWS role specified in the <profile> configuration'
    if test (count $argv) -eq 0
        set -e AWS_DEFAULT_PROFILE AWS_PROFILE AWS_EB_PROFILE
        set -e AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
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

    set -l profile $argv[1]
    set -l mfa_token ""
    if test (count $argv) -ge 2
        set mfa_token $argv[2]
    end

    # Get fallback credentials
    set -l aws_access_key_id (aws configure get aws_access_key_id --profile $profile)
    set -l aws_secret_access_key (aws configure get aws_secret_access_key --profile $profile)
    set -l aws_session_token (aws configure get aws_session_token --profile $profile)

    # Check for MFA configuration
    set -l mfa_serial (aws configure get mfa_serial --profile $profile)
    set -l sess_duration (aws configure get duration_seconds --profile $profile)

    set -l mfa_opt
    if test -n "$mfa_serial"
        if test -z "$mfa_token"
            read -P "Please enter your MFA token for $mfa_serial: " mfa_token
        end
        if test -z "$sess_duration"
            read -P "Please enter the session duration in seconds (900-43200; default: 3600): " sess_duration
        end
        set mfa_opt --serial-number $mfa_serial --token-code $mfa_token --duration-seconds (test -n "$sess_duration"; and echo $sess_duration; or echo "3600")
    end

    # Check for role assumption
    set -l role_arn (aws configure get role_arn --profile $profile)
    set -l sess_name (aws configure get role_session_name --profile $profile)

    set -l aws_command

    if test -n "$role_arn"
        # Assume a role
        set aws_command aws sts assume-role --role-arn $role_arn $mfa_opt

        # Check for external_id
        set -l external_id (aws configure get external_id --profile $profile)
        if test -n "$external_id"
            set aws_command $aws_command --external-id $external_id
        end

        # Get source profile
        set -l source_profile (aws configure get source_profile --profile $profile)
        if test -z "$sess_name"
            set sess_name (test -n "$source_profile"; and echo $source_profile; or echo "profile")
        end
        set aws_command $aws_command --profile (test -n "$source_profile"; and echo $source_profile; or echo "profile") --role-session-name $sess_name

        echo "Assuming role $role_arn using profile "(test -n "$source_profile"; and echo $source_profile; or echo "profile")
    else
        # Just get session token
        set aws_command aws sts get-session-token --profile $profile $mfa_opt
        echo "Obtaining session token for profile $profile"
    end

    # Add query and output format
    set aws_command $aws_command --query '[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]' --output text

    # Run the command and parse credentials
    set -l credentials (string split \t (eval $aws_command))

    if test (count $credentials) -ge 3
        set aws_access_key_id $credentials[1]
        set aws_secret_access_key $credentials[2]
        set aws_session_token $credentials[3]
    end

    # Export credentials
    if test -n "$aws_access_key_id"; and test -n "$aws_secret_access_key"
        set -gx AWS_DEFAULT_PROFILE $profile
        set -gx AWS_PROFILE $profile
        set -gx AWS_EB_PROFILE $profile
        set -gx AWS_ACCESS_KEY_ID $aws_access_key_id
        set -gx AWS_SECRET_ACCESS_KEY $aws_secret_access_key

        if test -n "$aws_session_token"
            set -gx AWS_SESSION_TOKEN $aws_session_token
        else
            set -e AWS_SESSION_TOKEN
        end

        echo "Switched to AWS Profile: $profile"
    end
end
