function aws_regions --description "Lists the available regions"
    set -l region
    if test -n "$AWS_DEFAULT_REGION"
        set region $AWS_DEFAULT_REGION
    else if test -n "$AWS_REGION"
        set region $AWS_REGION
    else
        set region us-west-1
    end

    if test -n "$AWS_DEFAULT_PROFILE"; or test -n "$AWS_PROFILE"
        aws ec2 describe-regions --region $region | grep RegionName | awk -F ':' '{gsub(/"/, "", $2);gsub(/,/, "", $2);gsub(/ /, "", $2); print $2}'
    else
        echo "You must specify a AWS profile."
    end
end
