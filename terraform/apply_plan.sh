function apply() {
    set +e
    terraform apply -input=false -no-color -auto-approve $1 | $TFMASK
    local TF_EXIT=${PIPESTATUS[0]}
    set -e

    if [[ $TF_EXIT -eq 0 ]]; then
        echo "Plan applied in CircleCI Job [${CIRCLE_JOB}](${CIRCLE_BUILD_URL})"
    else
        echo "Error applying plan in CircleCI Job [${CIRCLE_JOB}](${CIRCLE_BUILD_URL})"
        exit 1
    fi
}
plan=<< parameters.plan_file >>
echo "Applying plan: ${plan}"
apply $plan
