ROLE_ARN=${<< parameters.aws_role_to_assume >>}
if [ -z "$ROLE_ARN" ]; then
    exit 0
fi
echo "Running: aws sts assume-role --role-arn $ROLE_ARN"
res="$(aws sts assume-role --role-arn $ROLE_ARN --role-session-name CIRCLECI_TUTOK_DEPLOYMENT --output=json)"
export AWS_ACCESS_KEY_ID="$(echo $res | jq --raw-output .Credentials.AccessKeyId)"
export AWS_SECRET_ACCESS_KEY="$(echo $res | jq --raw-output .Credentials.SecretAccessKey)"
export AWS_SESSION_TOKEN="$(echo $res | jq --raw-output .Credentials.SessionToken)"
