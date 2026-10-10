
#!/bin/bash

folder_to_restore="$1"
quarantine_folder="$2"

mkdir -p "$folder_to_restore" "$quarantine_folder"

while true
do
    files=("$quarantine_folder"/*)

    if [ ! -f "${files[0]}" ]; then
        echo "No malicious files to review."
        break
    fi

    echo "Files in quarantine:"
    for i in "${!files[@]}"
    do
        echo "$((i + 1)). $(basename "${files[$i]}")"
    done

    echo "Enter file number to review (or 0 to exit):"
    read -r choice

    if [ "$choice" = "0" ]; then
        break
    fi

    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#files[@]}" ]; then
        echo "Invalid choice."
        continue
    fi

    selected_file="${files[$((choice - 1))]}"

    echo "1. Restore file"
    echo "2. Permanently delete file"
    echo "3. Return to file list"
    read -r action

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
            continue
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
done
