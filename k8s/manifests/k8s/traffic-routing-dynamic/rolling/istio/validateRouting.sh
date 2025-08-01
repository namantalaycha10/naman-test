#!/bin/bash

sleep 70

# Define the pod and container names
NAMESPACE="<+infra.namespace>"
CONTAINER_NAME={{ .Values.name }}"-traffic-generator"

POD_NAME=$(kubectl get pods -n $NAMESPACE | grep $CONTAINER_NAME | awk '{print $1}')

# Start tailing the logs and wait for "#DONE_COOKING#"
kubectl logs -n $NAMESPACE $POD_NAME $CONTAINER_NAME -f | awk '
/DONE_COOKING/ {
    getline;
    split($0, arr1, ": ");
    v1_count = arr1[2];
    getline;
    split($0, arr2, ": ");
    v2_count = arr2[2];
    print "V1_COUNT=" v1_count;
    print "V2_COUNT=" v2_count;
    exit;
}' > temp_envs.sh

# Source the extracted variables
if [ -s temp_envs.sh ]; then
    source temp_envs.sh

    targetForV1=900
    targetForV2=100
    percentage=30

    # Calculate the upper and lower bounds
    upper_bound_for_v1=$((targetForV1 + (targetForV1 * percentage / 100)))
    lower_bound_for_v1=$((targetForV1 - (targetForV1 * percentage / 100)))
    upper_bound_for_v2=$((targetForV2 + (targetForV2 * percentage / 100)))
    lower_bound_for_v2=$((targetForV2 - (targetForV2 * percentage / 100)))

    echo "Number of v1 responses: $V1_COUNT"
    echo "Number of v2 responses: $V2_COUNT"

    # Check if V1_COUNT is within the range
    if [ "$V1_COUNT" -ge "$lower_bound_for_v1" ] && [ "$V1_COUNT" -le "$upper_bound_for_v1" ]; then
        echo "The value of $V1_COUNT is within acceptable range of $targetForV1."
    else
        echo "The value of $V1_COUNT is NOT within acceptable range of $targetForV1."
        exit 1
    fi

    # Check if V1_COUNT is within the range
    if [ "$V2_COUNT" -ge "$lower_bound_for_v2" ] && [ "$V2_COUNT" -le "$upper_bound_for_v2" ]; then
        echo "The value of $V2_COUNT is within acceptable range of $targetForV2."
    else
        echo "The value of $V2_COUNT is NOT within acceptable range of $targetForV2."
        exit 1
    fi
else
    echo "No data extracted."
    exit 1
fi

# Cleanup
rm temp_envs.sh
