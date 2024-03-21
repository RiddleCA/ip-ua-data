#!/bin/bash
retries=0
max_retries=3
wait_time=10

while [ $retries -lt $max_retries ]; do
        git add .
        git config --global user.email "support@sitehost.co.nz"
        git config --global user.name "SiteHost NZ"
        git commit -m "Filter expired rate-limits" || echo "Nothing to commit"
        git pull --rebase origin main
        git push origin HEAD:main

    if [ $? -eq 0 ]; then
        echo "Git commands executed successfully."
        exit 0
    else
        retries=$((retries + 1))
        echo "Attempt $retries failed. Retrying..."
        sleep $wait_time
    fi
done

echo "All attempts failed. Exiting."
exit 1
