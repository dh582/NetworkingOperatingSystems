#!/bin/bash

# Capture the PID of the script
SCRIPT_PID=$$

# Function to generate UUID
root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#root@LAPTOP-MCNSLFRA:/mnt/c/Temp/AssessmentNetworking#generate_uuid() {
    local N=$1
    local FILENAME="uuid_$N.txt"

    if [ -f "$FILENAME" ]; then
        echo "Previous UUID exists: $(cat $FILENAME)"
    else
        local UUID=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 32 | head -n 1)
        echo "$UUID" > "$FILENAME"
        echo "UUID $N: $UUID"
        echo "$(date) - UUID $N generated" >> script_log.txt
    fi
}
# Run a command in the background
dony_command &

# Capture the PID of the command
SUBCOMMAND_PID=$!

# Use the captured PID as needed
echo "PID of the subcommand: $SUBCOMMAND_PID"

# Wait for the subprocess to finish (optional)
wait $SUBCOMMAND_PID

# Function to categorize content in _Directory folder
categorize_directory() {
    local DIRECTORY="_Directory"
    local REPORT_FILE="directory_report.txt"

    echo "Directory Report" > "$REPORT_FILE"
    echo "================" >> "$REPORT_FILE"

    for dir in "$DIRECTORY"/*/; do
        echo "Directory: $dir" >> "$REPORT_FILE"
        echo "----------------" >> "$REPORT_FILE"

        find "$dir" -type f | while read file; do
            echo "$(file -b --mime-type "$file")" >> "$REPORT_FILE"
        done

        total_size=$(du -sh "$dir" | awk '{print $1}')
        echo "Total space used: $total_size" >> "$REPORT_FILE"

        shortest_name=$(find "$dir" -type f -printf '%f\n' | awk '{ print length, $0 }' | sort -n | head -n 1 | cut -d ' ' -f 2)
        echo "Shortest file name: $shortest_name" >> "$REPORT_FILE"

        longest_name=$(find "$dir" -type f -printf '%f\n' | awk '{ print length, $0 }' | sort -nr | head -n 1 | cut -d ' ' -f 2)
        echo "Longest file name: $longest_name" >> "$REPORT_FILE"
    done
}

# Function to log script commands and user logins
log_activity() {
    local LOG_FILE="script_activity.log"
    echo "$(date) - User: $USER | PID: $$ | Command: $@" >> "$LOG_FILE"
}

# Check if script is run with arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 <option>"
    exit 1
fi

# Check the argument and execute corresponding functionality
case $1 in
    "uuid1")
        generate_uuid 1
        ;;
    "uuid2")
        generate_uuid 2
        ;;
    "uuid3")
        generate_uuid 3
        ;;
    "uuid4")
        generate_uuid 4
        ;;
    "uuid5")
        generate_uuid 5
        ;;
    "directory")
        categorize_directory
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac

# Log script activity
log_activity "$@"

exit 0

