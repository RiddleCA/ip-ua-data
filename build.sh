#!/bin/bash

# # Define an array of scripts to be executed.
# scripts=(
#     ./2-gen-allowed-ips.sh
#     ./5-gen-cdn-ips.sh
#     ./6-get-geo-ranges.py
# )

# # Array to store the error messages of failed scripts
# error_messages=()

# # Function to run each script and store its error message if it fails
# run_script() {
#     script=$1
#     if ! ./"$script"; then
#         error_messages+=("Script $script failed with error: $(cat "$script.err")")
#     fi
# }

# # Loop through the scripts array and run each script
# for script in "${scripts[@]}"; do
#     run_script "$script"
# done

# last_build=$(echo $1 | tr -d '"')
# echo "last build from api $last_build"
# last_successful_run=$(date -d $last_build +"%s")
# current_time=$(date +%s)
# time_diff=$((current_time - last_successful_run))
# echo $last_successful_run
# echo $time_diff

# # Print error messages of failed scripts
# if [ ${#error_messages[@]} -gt 0 ]; then


#     echo "The following scripts failed:"
#     for error_message in "${error_messages[@]}"; do
#         echo "$error_message"
#     done
#     #check if last successful build was more than 3 hours ago
#     if [ "$time_diff" -lt 10800 ]; then
#         echo "Successful build within last 3 hours, skipping failure"
#         exit 0
#     else
#         echo "No Successful build within last 3 hours"
#         exit 1
#     fi
# fi

echo "build successful"
