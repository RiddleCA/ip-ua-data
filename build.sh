#!/bin/bash

# Define an array of scripts to be executed.
scripts=(
    ./2-gen-allowed-ips.sh
    ./5-gen-cdn-ips.sh
    ./6-get-geo-ranges.py
)

# Array to store the error messages of failed scripts
error_messages=()

# Function to run each script and store its error message if it fails
run_script() {
    script=$1
    if ! ./"$script"; then
        error_messages+=("Script $script failed with error: $(cat "$script.err")")
    fi
}

# Function to convert ISO 8601 timestamp to epoch time
iso_to_epoch() {
    local iso_timestamp="$1"
    date -d "$iso_timestamp" +%s
}

# Loop through the scripts array and run each script
for script in "${scripts[@]}"; do
    run_script "$script"
done

current_time=$(date +%s)
last_successful_run=$(iso_to_epoch "$timestamp")
time_diff=$((current_time - last_successful_run))
echo $last_successful_run
echo $time_diff

# Print error messages of failed scripts
if [ ${#error_messages[@]} -gt 0 ]; then


    echo "The following scripts failed:"
    for error_message in "${error_messages[@]}"; do
        echo "$error_message"
    done
    #check if last successful build was more than 3 hours ago
    if [ "$time_diff" -lt 10800 ]; then
        echo "Successful build within last 3 hours, skipping failure"
        exit 0
    else
        echo "No Successful build within last 3 hours"
        exit 1
    fi
fi

echo "build successful"
