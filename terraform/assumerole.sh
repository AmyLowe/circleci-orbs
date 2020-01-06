ROLE_ARN=${<< parameters.aws_role_to_assume >>}
if [ -z "$ROLE" ]; then
    exit 0
fi
echo "Running: aws sts assume-role --role-arn $ROLE_ARN"
res="$(aws sts assume-role --role-arn $ROLE_ARN --output=json)"
echo $res
export AWS_ACCESS_KEY_ID="$(echo $res | jq --raw-output .Credentials.AccessKeyId)"
export AWS_SECRET_ACCESS_KEY="$(echo $res | jq --raw-output .Credentials.SecretAccessKey)"
export AWS_SESSION_TOKEN="$(echo $res | jq --raw-output .Credentials.SessionToken)"
