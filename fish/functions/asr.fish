function asr --description 'Sets AWS_REGION'
    if test (count $argv) -eq 0
        set -e AWS_DEFAULT_REGION AWS_REGION
        _aws_update_state
        echo "AWS region cleared."
        return
    end

    set -l available_regions (aws_regions)
    set -l region_found 0
    for reg in $available_regions
        if test "$reg" = "$argv[1]"
            set region_found 1
            break
        end
    end

    if test $region_found -eq 0
        set_color red
        echo "Available regions:"
        aws_regions
        set_color normal
        return 1
    end

    set -gx AWS_REGION $argv[1]
    set -gx AWS_DEFAULT_REGION $argv[1]
    _aws_update_state
end
