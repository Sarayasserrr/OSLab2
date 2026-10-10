#!/bin/bash

folder_to_restore="$1"
quarantine_folder="$2"

while true
do
    if [ ! -d "$quarantine_folder" ] || [ -z "$(ls -A "$quarantine_folder")" ]; then
        echo "No malicious files to review."
        break
    fi

    echo "Files in quarantine:"

    i=1
    for file in "$quarantine_folder"/*
    do
        if [ -f "$file" ]; then
            echo "$i. $(basename "$file")"
            i=$((i + 1))
        fi
    done

    echo "Enter file number to review (or 0 to exit):"
    read choice

    if [ "$choice" = "0" ]; then
        break
    fi

    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -ge "$i" ]; then
        echo "Invalid choice."
        continue
    fi

    i=1
    for file in "$quarantine_folder"/*
    do
        if [ -f "$file" ]; then
            if [ "$i" -eq "$choice" ]; then
                selected_file="$file"
                break
            fi
            i=$((i + 1))
        fi
    done

    echo "1. Restore file"
    echo "2. Permanently delete file"
    echo "3. Return to file list"
    read action

    case "$action" in
        1)
            if mv "$selected_file" "$folder_to_restore/"; then
                echo "Restored $(basename "$selected_file") to $folder_to_restore."
            fi
            ;;
        2)
            if rm "$selected_file"; then
                echo "$(basename "$selected_file") permanently deleted."
            fi
            ;;
        3)
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
done
