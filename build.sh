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

# Loop through the scripts array and run each script
for script in "${scripts[@]}"; do
    run_script "$script"
done

echo $1

# Print error messages of failed scripts
if [ ${#error_messages[@]} -gt 0 ]; then
    echo "The following scripts failed:"
    for error_message in "${error_messages[@]}"; do
        echo "$error_message"
    done
    exit 1
fi
